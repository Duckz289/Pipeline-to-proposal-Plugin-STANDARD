# Manual Test Cases

Use these prompts after changing routing, local memory, Vietnamese copy, or output length.

## 1. Simple Full Run

```text
Chạy cho ABC Logistics. Tao bán phần mềm quản lý kho 3 triệu/tháng. Cần brief, email ngắn và next step.
```

Check:

- compact output
- no setup friction
- no invented public facts
- local memory/follow-up saved or suggested
- no debug terms such as confidence/source health in normal output

## 2. Vietnamese SME With Sparse Data

```text
Research công ty TNHH Minh An, SME Việt Nam. Tao chỉ biết họ bán vật liệu xây dựng, muốn tiếp cận chủ doanh nghiệp.
```

Check:

- persona-based recommendation
- one useful context question at most
- plain wording about weak data
- no fake decision maker

## 3. Proposal Skeleton

```text
Soạn proposal cho Local Mart. Tao bán dịch vụ chạy quảng cáo nhưng chưa chốt ngân sách.
```

Check:

- short skeleton
- pricing marker
- ROI framed as assumptions

## 4. Follow-Up Reminder

```text
Viết follow-up cho Summit. Proposal gửi 5 ngày trước, khách im lặng.
```

Check:

- short follow-up
- timing is used
- reminder block created

## 5. Product Context

```text
Lưu context sản phẩm: tao bán dịch vụ AI automation cho phòng sales B2B, giá từ 10 triệu/tháng.
```

Check:

- saves starter context when possible
- missing ICP/proof/CTA marked clearly

## 6. CRM Note Draft

```text
Tạo note CRM cho deal Beta: đã demo, khách hỏi giá gói 20 user, cần gửi proposal thứ Sáu.
```

Check:

- copy-paste note
- follow-up task
- no claim of external write

## 7. Feedback Prompt

```text
Viết email chào hàng cho Beta. Tao bán dịch vụ kế toán thuê ngoài.
```

Check:

- short email
- one short "tell me what happened" prompt
- pending feedback saved or suggested

## 8. Feedback Updates Stage

```text
Khách Beta reply rồi, họ muốn hẹn demo tuần sau.
```

Check:

- deal stage becomes Replied or Meeting booked
- deal index is updated
- next action is specific
- no long feedback form
- reply draft is suggested

## 9. Thirty-Second Onboarding

```text
Chạy cho ABC. Tao bán phần mềm quản lý kho, giá 3 triệu/tháng. Cần email ngắn.
```

Check:

- no setup form
- output has max 3 sections
- saves product/deal memory if possible

## 10. Artifact-Only Fallback

```text
Chạy cho An Phát Logistics. Nếu host không ghi được vào local-state mà chỉ tạo file markdown tải xuống thì đừng nói đã lưu.
```

Check:

- does not count artifact/temp files as saved memory
- uses a compact `Để lưu lại` block instead
- only shows `Đã lưu` when exact `local-state/...` paths were updated
