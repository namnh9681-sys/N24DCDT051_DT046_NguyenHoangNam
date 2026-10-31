# DT046 — TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT

Báo cáo tiến độ 2 (Mốc 2) — Học phần Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03).

## 1. Thông tin sinh viên & Đề tài

- **Họ và tên**: Nguyễn Hoàng Nam
- **Mã số sinh viên**: N24DCDT051
- **Lớp**: D24CQDT01-N
- **Mã đề tài**: DT046
- **Tên đề tài**: Tìm đồng thời giá trị nhỏ nhất và lớn nhất
- **Giảng viên hướng dẫn**: Hồ Nhựt Minh
- **Khoa**: Kỹ thuật Điện tử 2 | **Ngành**: Kỹ thuật Điện - Điện tử
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
├── demo.jl              # Kịch bản chạy demo tổng hợp (2 ví dụ + ca tự thiết kế + biên + lỗi)
├── benchmark.jl         # Kịch bản đo đạc thực nghiệm trên 4 quy mô n in {5, 20, 100, 500}
├── README.md            # Tài liệu hướng dẫn và thông tin đồ án
├── src/
│   └── DeTai.jl         # Module DeTai: kiem_tra_dau_vao, min_max, min_max_truc_tiep, giai_bai
├── test/
│   └── runtests.jl      # Bộ kiểm thử toàn diện 12 ca độc lập (45 phép assert PASS)
└── docs/
    └── anh_ket_qua/     # Thư mục 11 ảnh minh chứng A01 - A11
```

---

## 4. Hướng dẫn chạy chương trình

Mở terminal / PowerShell tại thư mục đồ án:

```powershell
# 1. Kiểm tra phiên bản Julia
julia --version

# 2. Chạy kịch bản Demo tổng hợp
julia --startup-file=no demo.jl

# 3. Chạy đo đạc thực nghiệm 4 quy mô n in {5, 20, 100, 500}
julia --startup-file=no benchmark.jl

# 4. Chạy toàn bộ bộ kiểm thử 12 ca độc lập
julia --startup-file=no test/runtests.jl
```

---

## 5. Kết quả thực thi các ca cơ sở trên phiếu đề tài

| Ca kiểm tra | Input `a` | Expected Output | Kết quả thực tế | Trạng thái |
| :--- | :--- | :--- | :--- | :--- |
| **Ví dụ 1 (VD01)** | `[-3, 7, 2, 9]` | `min = -3, max = 9, so_sanh = 4` | `(-3, 9, 4)` | **PASS** |
| **Ví dụ 2 (VD02)** | `[5]` | `min = 5, max = 5, so_sanh = 0` | `(5, 5, 0)` | **PASS** |
| **Ca 1 (KT09)** | `[8, 2]` | `min = 2, max = 8, so_sanh = 1` | `(2, 8, 1)` | **PASS** |
| **Ca 2 (TK02)** | `[4, 4]` | `min = 4, max = 4, so_sanh = 1` | `(4, 4, 1)` | **PASS** |
| **Ca 3 (KT10)** | `[-5, -1, -3]` | `min = -5, max = -1, so_sanh = 3` | `(-5, -1, 3)` | **PASS** |
| **Ca 4 (KT11)** | `[1, 2, 3, 4, 5, 6, 7, 8]` | `min = 1, max = 8, so_sanh = 10` | `(1, 8, 10)` | **PASS** |
| **Ca 5 (KT12)** | `[9, 1, 7, 3, 5]` | `min = 1, max = 9, so_sanh = 6` | `(1, 9, 6)` | **PASS** |
| **Tự thiết kế 1 (TK01)** | `[100, 50, 20, 10, 0, -10]` | `min = -10, max = 100, so_sanh = 8` | `(-10, 100, 8)` | **PASS** |
| **Tự thiết kế 2 (TK02)** | `[7, 7, 7, 7]` | `min = 7, max = 7, so_sanh = 4` | `(7, 7, 4)` | **PASS** |
| **Biên 1 (BIEN01)** | `[-1000]` | `min = -1000, max = -1000, so_sanh = 0` | `(-1000, -1000, 0)` | **PASS** |
| **Biên 2 (BIEN02)** | `[-1000, 1000]` | `min = -1000, max = 1000, so_sanh = 1` | `(-1000, 1000, 1)` | **PASS** |
| **Biên 3 (BIEN03)** | `a_1024` ($n=1024$) | `min = -500, max = 500, so_sanh = 1534` | `(-500, 500, 1534)` | **PASS** |

- **Tổng kết kiểm thử**: Đạt 45/45 phép kiểm tra (12 ca độc lập) trong `test/runtests.jl`.
- **Hiệu quả thực nghiệm**: Thuật toán chia để trị thực hiện $T(n) = \frac{3n}{2} - 2$ phép so sánh (với $n = 2^k$), tiết kiệm $\approx 25\%$ số phép so sánh so với duyệt trực tiếp $2n - 2$.

---

## 6. Mốc Git Commit C (Tiến độ 2)

- **Commit message chuẩn**: `feat: complete algorithm, 12 test cases and benchmark`
- **Mã SHA C (40 ký tự)**: `43bc4a301fafb9d54c9396c20bfcfe67fded5a1e` (và commit gốc: `6a186eace8934a81795104bc494d83eb3633124e`)
- **Permalink tệp thuật toán chính tại C**: [src/DeTai.jl](https://github.com/namnh9681-sys/N24DCDT051_DT046_NguyenHoangNam/blob/43bc4a301fafb9d54c9396c20bfcfe67fded5a1e/src/DeTai.jl)
- **Permalink tệp bộ kiểm thử tại C**: [test/runtests.jl](https://github.com/namnh9681-sys/N24DCDT051_DT046_NguyenHoangNam/blob/43bc4a301fafb9d54c9396c20bfcfe67fded5a1e/test/runtests.jl)
- **URL Commit C**: [Commit 43bc4a3](https://github.com/namnh9681-sys/N24DCDT051_DT046_NguyenHoangNam/commit/43bc4a301fafb9d54c9396c20bfcfe67fded5a1e)

