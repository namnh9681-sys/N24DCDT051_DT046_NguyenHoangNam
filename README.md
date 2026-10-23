# DT046 — TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT

Báo cáo tiến độ 1 — Học phần Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03).

## 1. Thông tin sinh viên & Đề tài

- **Họ và tên**: Nguyễn Hoàng Nam
- **Mã số sinh viên**: N24DCDT051
- **Lớp**: D24CQDT01-N
- **Mã đề tài**: DT046
- **Tên đề tài**: Tìm đồng thời giá trị nhỏ nhất và lớn nhất
- **Giảng viên hướng dẫn**: Hồ Nhựt Minh
- **Căn cứ giáo trình**: *Giáo trình Cấu trúc dữ liệu và Giải thuật (INT1306)* — Chương 4, Mục 4.1.3 "Tìm đồng thời giá trị nhỏ nhất và lớn nhất"; Bài tập chương 4, câu 18; Trang in: 91–92, 111; Trang PDF: 103–104, 123.
- **Ngôn ngữ lập trình & Phiên bản**: Julia 1.12.7
- **URL Repository GitHub**: `https://github.com/namnh9681-sys/N24DCDT051_DT046_NguyenHoangNam`

---

## 2. Đặc tả bài toán & Hợp đồng Input / Output

### 2.1. Đề bài
Viết chương trình tìm cả số nhỏ nhất và lớn nhất bằng cách chia mảng thành các đoạn. Xử lý riêng đoạn một hoặc hai phần tử, rồi ghép hai cặp kết quả từ hai nửa. Bài làm chú trọng đếm phép so sánh và giải thích vì sao xử lý hai phần tử bằng một lần so sánh có lợi.

### 2.2. Dữ liệu vào (Input Contract)
- Mảng `a` gồm $1 \le n \le 1024$ số nguyên.
- Mỗi phần tử $a[i] \in [-1000, 1000]$.
- Mảng không được rỗng. Được phép nhận mảng có giá trị trùng lặp.
- Đoạn chỉ số $l$ đến $r$ ($1 \le l \le r \le n$), tính cả hai đầu.

### 2.3. Dữ liệu ra (Output Contract)
- Bộ 3 giá trị `(min_val, max_val, so_sanh)`:
  - `min_val`: Giá trị nhỏ nhất trong đoạn $a[l:r]$.
  - `max_val`: Giá trị lớn nhất trong đoạn $a[l:r]$.
  - `so_sanh`: Số phép so sánh giá trị giữa các phần tử do hàm chia để trị thực hiện (không tính phép kiểm tra điều kiện $l = r$).

---

## 3. Cấu trúc mã nguồn

```
N24DCDT051_DT046_NguyenHoangNam/
├── .gitignore
├── demo.jl              # Kịch bản chạy demo 2 ví dụ và 5 ca kiểm tra
├── README.md            # Tài liệu hướng dẫn và thông tin đồ án
├── src/
│   └── DeTai.jl         # Module DeTai: kiem_tra_dau_vao, min_max, min_max_truc_tiep, giai_bai
├── test/
│   └── runtests.jl      # Bộ kiểm thử 34 phép assert (6 nhóm ca kiểm tra)
└── docs/
    └── anh_ket_qua/     # Thư mục lưu trữ hình ảnh minh chứng
```

---

## 4. Hướng dẫn chạy chương trình

Mở terminal / PowerShell tại thư mục đồ án:

```powershell
# 1. Kiểm tra phiên bản Julia
julia --version

# 2. Chạy kịch bản Demo (2 ví dụ + 5 ca trên phiếu)
julia --startup-file=no demo.jl

# 3. Chạy toàn bộ các ca kiểm thử tự động
julia --startup-file=no test/runtests.jl
```

---

## 5. Kết quả thực thi các ca cơ sở trên phiếu đề tài

| Ca kiểm tra | Input `a` | Expected Output | Kết quả thực tế | Trạng thái |
| :--- | :--- | :--- | :--- | :--- |
| **Ví dụ 1** | `[-3, 7, 2, 9]` | `min = -3, max = 9, so_sanh = 4` | `(-3, 9, 4)` | **PASS** |
| **Ví dụ 2** | `[5]` | `min = 5, max = 5, so_sanh = 0` | `(5, 5, 0)` | **PASS** |
| **Ca 1** | `[8, 2]` | `min = 2, max = 8, so_sanh = 1` | `(2, 8, 1)` | **PASS** |
| **Ca 2** | `[4, 4]` | `min = 4, max = 4, so_sanh = 1` | `(4, 4, 1)` | **PASS** |
| **Ca 3** | `[-5, -1, -3]` | `min = -5, max = -1, so_sanh = 3` | `(-5, -1, 3)` | **PASS** |
| **Ca 4** | `[1, 2, 3, 4, 5, 6, 7, 8]` | `min = 1, max = 8, so_sanh = 10` | `(1, 8, 10)` | **PASS** |
| **Ca 5** | `[9, 1, 7, 3, 5]` | `min = 1, max = 9, so_sanh = 6` | `(1, 9, 6)` | **PASS** |

- **Tổng kết kiểm thử**: Đạt 34/34 phép kiểm tra trong `test/runtests.jl`.
- **Hiệu quả**: Khi $n = 2^k$, thuật toán chia để trị thực hiện $T(n) = \frac{3n}{2} - 2$ phép so sánh, tiết kiệm khoảng $25\%$ số phép so sánh so với phương pháp duyệt trực tiếp $2n - 2$.
