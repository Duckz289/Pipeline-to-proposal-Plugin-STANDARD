# Pipeline-to-Proposal

Plugin local-first cho sales B2B. Một người sale bình thường có thể gõ một câu ngắn và nhận ngay
tóm tắt, email, proposal nháp, bước tiếp theo, hoặc note để lưu deal.

## Cách dùng trong 30 giây

Gõ một câu như này:

```text
Chạy cho ABC. Tao bán [mình bán gì], giá [nếu có]. Cần email ngắn và bước tiếp theo.
```

Sau đó cứ báo kết quả:

```text
Khách ABC reply rồi, họ muốn hẹn demo tuần sau.
```

Plugin sẽ tự cập nhật deal, gợi ý tin nhắn trả lời và lưu follow-up nếu môi trường cho phép.

Không cần server riêng. Không có server bundled. Không cần Docker/MySQL. Bản này ưu tiên chạy
trong máy/local workspace, dùng dữ liệu người dùng paste vào và bộ nhớ file trong `local-state/`.

## Ví dụ nhanh

Gõ tự nhiên, ví dụ:

```text
Chạy cho ABC Logistics. Tao bán phần mềm quản lý kho 3 triệu/tháng. Viết email ngắn và gợi ý bước tiếp theo.
```

Hoặc:

```text
Viết follow-up cho deal FPT. Đã gửi proposal 5 ngày trước, khách chưa trả lời.
```

Plugin sẽ tự:

1. Hiểu mục tiêu.
2. Dùng context có sẵn trước.
3. Research nhẹ nếu có công cụ/tài liệu.
4. Nếu thiếu dữ liệu, hỏi sớm tối đa 1 câu dễ trả lời.
5. Trả output ngắn, dễ copy.
6. Tự lưu deal/follow-up/feedback vào `local-state/` khi môi trường cho phép.

## Skill chính

- `run-pipeline`: chạy từ research đến email/proposal/next step khi user muốn làm nhiều việc.
- `research-prospect`: tạo prospect brief ngắn.
- `draft-outreach-email`: viết cold email, follow-up, LinkedIn message, call opener.
- `draft-proposal`: tạo proposal nháp hoặc skeleton khi thiếu pricing/scope.
- `suggest-next-step`: gợi ý hành động tiếp theo cho deal.
- `setup-product-context`: chuẩn hóa "mình bán gì" để dùng lại.
- `mode-selector`: chỉ dùng khi user bắt đầu quá mơ hồ.
- `sync-crm`: tạo note/task draft để user tự copy vào CRM; không tự ghi CRM.
- `update-deal-feedback`: cập nhật deal khi user báo khách reply/no reply/won/lost/meeting.

## Local Memory

Plugin lưu memory bằng file local:

- `local-state/product-context.md`: offer, pricing, ICP, proof, CTA.
- `local-state/deals/index.md`: bảng xem nhanh các deal.
- `local-state/deals/`: lịch sử từng công ty/deal.
- `local-state/follow-ups.md`: nhắc follow-up thủ công.
- `local-state/feedback.md`: reply, win/loss, objection, edit của user.

Khi host cho phép ghi file, plugin ưu tiên sửa markdown trực tiếp. Nếu host có shell thì có thể dùng
script local. Nếu cả hai đều không có, plugin mới trả một block ngắn để user giữ lại.

## Khi public data yếu

Với startup, SME Việt Nam, công ty nhỏ hoặc công ty ít dấu vết public, plugin không cố bịa. Nó sẽ:

- dùng website/MST/context user cung cấp nếu có
- chuyển sang persona-based outreach nếu không tìm được decision maker
- hỏi sớm một câu tự nhiên nếu câu trả lời làm email/proposal tốt hơn rõ rệt
- nếu user chưa có thêm thông tin, viết bản trung tính cho persona phù hợp

Ví dụ câu hỏi tốt:

```text
ABC bán cho ngành nào vậy? Nếu chưa rõ, tao sẽ viết bản trung tính cho owner/head of ops.
```

## Product Context

Nếu chưa setup, cứ gõ offer ngay trong câu lệnh:

```text
Chạy cho An Phát. Tao bán dịch vụ AI automation cho sales team, từ 10 triệu/tháng.
```

Khi muốn lưu lâu dài:

```text
Lưu context sản phẩm: tao bán ...
```

Nếu `local-state/product-context.md` đang trống, plugin có thể lưu starter context từ chính câu
lệnh đầu tiên. Chỉ hỏi duyệt khi cần ghi đè context đã có.

## Output mặc định

Mặc định ngắn, ít thuật ngữ:

- Kết quả
- Nội dung gửi hoặc proposal nháp
- Cần bổ sung, nếu thật sự quan trọng
- Việc tiếp theo
- Đã lưu, nếu có cập nhật local memory

Không tạo email dài, proposal dài, nhiều biến thể, hoặc report dài trừ khi user yêu cầu.

## Giới hạn

- Research public có thể yếu với công ty nhỏ hoặc ít xuất hiện online.
- ROI chỉ là framework nếu chưa có số thật từ buyer/user.
- Plugin không tự gửi email, không tự ghi CRM, không tự gọi server ngoài.
- Nhắc follow-up là danh sách local trong `local-state/follow-ups.md`, không phải notification hệ thống.
- Sau mỗi draft gửi khách, plugin nhắc một câu ngắn để user báo kết quả và cập nhật deal.

## Privacy

Plugin local-first. Tác giả plugin không nhận dữ liệu prospect, CRM, email, proposal, hay lịch sử
deal từ runtime plugin.

## Release Note

Version `0.4.4`:

- dùng `0.4.4` làm version chính thức của source folder hiện tại
- giữ format package chuẩn để `.plugin` và `.zip` không lỗi path trong archive
- cập nhật mô tả sản phẩm ngắn gọn hơn cho release/marketplace

Version `0.4.3`:

- local memory không còn phụ thuộc PowerShell: ưu tiên ghi markdown trực tiếp, rồi mới dùng script
- feedback sau khi khách reply sẽ tự gợi ý tin nhắn trả lời
- output normal giữ tối đa 3 phần, chỉ lên 4 phần nếu user yêu cầu nhiều artifact
- thêm phần "Cách dùng trong 30 giây" ở đầu README
- email/proposal templates gộp bớt section để sale đọc nhanh hơn

Version `0.4.2`:

- thêm skill `update-deal-feedback` để cập nhật deal khi user báo reply/no reply/won/lost/meeting
- script local memory tự tạo `deals/index.md` và cập nhật stage/next action theo feedback
- slug deal rõ hơn, tự bỏ dấu tiếng Việt khi tạo file
- output cap chặt hơn: mặc định tối đa 3 section
- câu hỏi khi thiếu dữ liệu cụ thể hơn theo ngành/persona thay vì hỏi chung chung

Version `0.4.1`:

- local memory chủ động hơn: tự tạo/update deal file, follow-up, feedback pending khi có thể
- sparse-data research hỏi sớm một câu tự nhiên rồi mới viết bản trung tính
- output mặc định đổi sang ngôn ngữ thường: Kết quả / Nội dung gửi / Việc tiếp theo / Đã lưu
- onboarding mềm hơn: nếu user nói offer trong câu đầu, plugin có thể lưu starter product context
- feedback loop nhẹ hơn: sau mỗi draft chỉ nhắc user báo reply/no reply để cập nhật deal

Version `0.4.0`:

- removed bundled server/database/background-worker docs from source
- removed server registration from plugin manifest
- added `local-state/` for product context, deal memory, follow-ups, and feedback
- simplified README and usage around one-sentence sales commands
- changed pipeline behavior to ask fewer questions and produce shorter, copy-ready outputs
- changed CRM sync skill into local note/task drafting only
- made public search optional instead of tied to one search API

Older packaged `.zip` and `.plugin` files in the parent folder are left untouched.
