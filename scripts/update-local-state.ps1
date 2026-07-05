param(
  [Parameter(Mandatory = $true)]
  [string]$Company,

  [string]$Offer = "",
  [string]$Stage = "",
  [string]$Contact = "",
  [string]$LastTouch = "",
  [string]$NextAction = "",
  [string]$History = "",
  [string]$DraftType = "",
  [string]$DraftSummary = "",
  [string]$FollowupDate = "",
  [string]$FeedbackResult = "pending",
  [string]$FeedbackText = ""
)

$ErrorActionPreference = "Stop"

function Remove-Diacritics([string]$value) {
  if ([string]::IsNullOrWhiteSpace($value)) { return "" }
  $normalized = $value.Normalize([Text.NormalizationForm]::FormD)
  $builder = New-Object System.Text.StringBuilder
  foreach ($ch in $normalized.ToCharArray()) {
    $category = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch)
    if ($category -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
      [void]$builder.Append($ch)
    }
  }
  return $builder.ToString().Normalize([Text.NormalizationForm]::FormC)
}

function New-Slug([string]$value) {
  $ascii = Remove-Diacritics $value
  $slug = $ascii.ToLowerInvariant() -replace '[^a-z0-9]+', '-'
  $slug = $slug.Trim('-')
  if ([string]::IsNullOrWhiteSpace($slug)) { return "deal" }
  return $slug
}

function Infer-DealState([string]$stage, [string]$feedback, [string]$draftType) {
  $text = (Remove-Diacritics ($stage + " " + $feedback + " " + $draftType)).ToLowerInvariant()

  if ($text -match 'won|closed won|thang|chot|ky hop dong') { return "Won" }
  if ($text -match 'lost|closed lost|mat deal|khong mua|chon ben khac') { return "Lost" }
  if ($text -match 'book|meeting|demo|hen gap|hen call|dat lich|len lich') { return "Meeting booked" }
  if ($text -match 'reply|replied|phan hoi|tra loi|quan tam|interested') { return "Replied" }
  if ($text -match 'proposal|de xuat|bao gia|quote') { return "Proposal sent" }
  if ($text -match 'no reply|khong phan hoi|chua phan hoi|im lang|chua tra loi') { return "Waiting reply" }
  if ($text -match 'follow') { return "Follow-up" }
  if ($text -match 'cold|moi|new') { return "New" }
  if (-not [string]::IsNullOrWhiteSpace($stage)) { return $stage }
  return "New"
}

function Infer-NextAction([string]$currentAction, [string]$state, [string]$feedback) {
  if (-not [string]::IsNullOrWhiteSpace($currentAction)) { return $currentAction }

  $text = (Remove-Diacritics $feedback).ToLowerInvariant()
  if ($state -eq "Replied") { return "Reply and lock the next step" }
  if ($state -eq "Meeting booked") { return "Prepare meeting agenda" }
  if ($state -eq "Proposal sent") { return "Follow up on proposal" }
  if ($state -eq "Waiting reply") { return "Send light follow-up" }
  if ($state -eq "Won") { return "Record win reason and handoff" }
  if ($state -eq "Lost") { return "Record lost reason and nurture date" }
  if ($text -match 'objection|phan doi|lo gia|dat|chua co ngan sach') { return "Draft objection response" }
  return "Choose next step"
}

function Set-Section([string]$content, [string]$heading, [string]$newBody) {
  $pattern = "(?ms)^## $([regex]::Escape($heading))\r?\n.*?(?=^## |\z)"
  $replacement = "## $heading`n$newBody`n"
  if ($content -match $pattern) {
    return [regex]::Replace($content, $pattern, $replacement)
  }
  return ($content.TrimEnd() + "`n`n" + $replacement)
}

$pluginRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$localRoot = Join-Path $pluginRoot "local-state"
$dealsRoot = Join-Path $localRoot "deals"

New-Item -ItemType Directory -Force -Path $localRoot | Out-Null
New-Item -ItemType Directory -Force -Path $dealsRoot | Out-Null

$slug = New-Slug $Company
$dealFile = Join-Path $dealsRoot "$slug.md"
$today = (Get-Date).ToString("yyyy-MM-dd")
$inferredStage = Infer-DealState $Stage $FeedbackText $DraftType
$inferredNext = Infer-NextAction $NextAction $inferredStage $FeedbackText
$touch = if ([string]::IsNullOrWhiteSpace($LastTouch)) { $today } else { $LastTouch }

if (-not (Test-Path -LiteralPath $dealFile)) {
  Set-Content -LiteralPath $dealFile -Encoding UTF8 -Value "# $Company`n"
}

$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $dealFile

$summary = @"
- Offer: $Offer
- Stage: $inferredStage
- Contact/persona: $Contact
- Last touch: $touch
- Next action: $inferredNext
"@

$content = Set-Section $content "Summary" $summary

$historyLines = New-Object System.Collections.Generic.List[string]
if (-not [string]::IsNullOrWhiteSpace($History)) {
  $historyLines.Add("- ${today}: $History")
}
if (-not [string]::IsNullOrWhiteSpace($FeedbackText)) {
  $historyLines.Add("- ${today}: Feedback - $FeedbackText")
}
if (-not [string]::IsNullOrWhiteSpace($inferredNext)) {
  $historyLines.Add("- ${today}: Next action - $inferredNext")
}

if ($historyLines.Count -gt 0) {
  $historyBlock = ($historyLines -join [Environment]::NewLine)
  if ($content -match '(?ms)^## History\r?\n(?<body>.*?)(?=^## |\z)') {
    $oldBody = $Matches['body'].TrimEnd()
    $newHistory = if ([string]::IsNullOrWhiteSpace($oldBody)) { $historyBlock } else { $oldBody + "`n" + $historyBlock }
    $content = Set-Section $content "History" $newHistory
  } else {
    $content = Set-Section $content "History" $historyBlock
  }
}

if (-not [string]::IsNullOrWhiteSpace($DraftType) -or -not [string]::IsNullOrWhiteSpace($DraftSummary)) {
  $draftLabel = if ([string]::IsNullOrWhiteSpace($DraftType)) { "Draft" } else { $DraftType }
  $draftBody = "- ${today}: $draftLabel - $DraftSummary"
  $content = Set-Section $content "Latest draft" $draftBody
}

if ($content -notmatch '(?m)^## Open questions') {
  $content = $content.TrimEnd() + "`n`n## Open questions`n"
}

Set-Content -LiteralPath $dealFile -Value $content.TrimEnd() -Encoding UTF8

$followupFile = Join-Path $localRoot "follow-ups.md"
if (-not (Test-Path -LiteralPath $followupFile)) {
  Set-Content -LiteralPath $followupFile -Value "# Follow-Ups`n" -Encoding UTF8
}
if (-not [string]::IsNullOrWhiteSpace($FollowupDate) -and -not [string]::IsNullOrWhiteSpace($inferredNext)) {
  $line = "- [ ] $FollowupDate - $Company - $inferredNext - $inferredStage"
  $existingFollowups = Get-Content -Raw -Encoding UTF8 -LiteralPath $followupFile
  if ($existingFollowups -notlike "*$line*") {
    Add-Content -LiteralPath $followupFile -Value $line -Encoding UTF8
  }
}

$feedbackFile = Join-Path $localRoot "feedback.md"
if (-not (Test-Path -LiteralPath $feedbackFile)) {
  Set-Content -LiteralPath $feedbackFile -Value "# Feedback`n" -Encoding UTF8
}
if (-not [string]::IsNullOrWhiteSpace($DraftType) -or -not [string]::IsNullOrWhiteSpace($FeedbackText) -or $FeedbackResult -ne "pending") {
  $result = if (-not [string]::IsNullOrWhiteSpace($FeedbackText) -and $FeedbackResult -eq "pending") { $inferredStage } else { $FeedbackResult }
  $feedback = @"

## $today - $Company
- Output: $DraftType
- Result: $result
- Buyer said: $FeedbackText
- Next action: $inferredNext
"@
  Add-Content -LiteralPath $feedbackFile -Value $feedback -Encoding UTF8
}

$indexFile = Join-Path $dealsRoot "index.md"
$indexHeader = "# Deal Index`n`n| Company | Stage | Last touch | Next action | File |`n|---|---|---|---|---|"
if (-not (Test-Path -LiteralPath $indexFile)) {
  Set-Content -LiteralPath $indexFile -Value $indexHeader -Encoding UTF8
}
$index = Get-Content -Raw -Encoding UTF8 -LiteralPath $indexFile
$row = "| $Company | $inferredStage | $touch | $inferredNext | $slug.md |"
$escapedCompany = [regex]::Escape($Company)
$rowPattern = "(?m)^\| $escapedCompany \|.*$"
if ($index -match $rowPattern) {
  $index = [regex]::Replace($index, $rowPattern, $row)
  Set-Content -LiteralPath $indexFile -Value $index.TrimEnd() -Encoding UTF8
} else {
  Add-Content -LiteralPath $indexFile -Value $row -Encoding UTF8
}

[pscustomobject]@{
  Company = $Company
  Stage = $inferredStage
  NextAction = $inferredNext
  DealFile = $dealFile
  Index = $indexFile
  FollowUps = $followupFile
  Feedback = $feedbackFile
}
