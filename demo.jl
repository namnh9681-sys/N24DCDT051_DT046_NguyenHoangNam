# ==============================================================================
# HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG - CƠ SỞ TẠI TP. HỒ CHÍ MINH
# HỌC PHẦN: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT (INT13185) - NHÓM 03
# GIẢNG VIÊN HƯỚNG DẪN: HỒ NHỰT MINH
# SINH VIÊN: NGUYỄN HOÀNG NAM - MSSV: N24DCDT051 - LỚP: D24CQDT01-N
# ĐỀ TÀI: DT046 - TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

println("="^75)
println("DEMO ĐỀ TÀI DT046: TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT")
println("Sinh viên: Nguyễn Hoàng Nam | MSSV: N24DCDT051 | Lớp: D24CQDT01-N")
println("="^75)

# --- 1. CHẠY THỬ NGHIỆM VÍ DỤ 1 TRÊN PHIẾU GIAO ĐỀ TÀI ---
println("\n[VÍ DỤ 1 TRÊN PHIẾU]")
a1 = [-3, 7, 2, 9]
println("Dữ liệu vào a: ", a1)
min1, max1, ss1 = giai_bai(a1)
_, _, ss1_tt = min_max_truc_tiep(a1)
println("Kết quả Chia để trị : min = $min1, max = $max1, số phép so sánh = $ss1")
println("Kỳ vọng trên phiếu   : min = -3, max = 9, so_sanh = 4")
println("Duyệt trực tiếp (2n-2): số phép so sánh = $ss1_tt")
println("Đánh giá: ", (min1 == -3 && max1 == 9 && ss1 == 4) ? "CHÍNH XÁC (ĐẠT)" : "CHƯA ĐẠT")

# --- 2. CHẠY THỬ NGHIỆM VÍ DỤ 2 TRÊN PHIẾU GIAO ĐỀ TÀI ---
println("\n[VÍ DỤ 2 TRÊN PHIẾU]")
a2 = [5]
println("Dữ liệu vào a: ", a2)
min2, max2, ss2 = giai_bai(a2)
_, _, ss2_tt = min_max_truc_tiep(a2)
println("Kết quả Chia để trị : min = $min2, max = $max2, số phép so sánh = $ss2")
println("Kỳ vọng trên phiếu   : min = 5, max = 5, so_sanh = 0")
println("Duyệt trực tiếp     : số phép so sánh = $ss2_tt")
println("Đánh giá: ", (min2 == 5 && max2 == 5 && ss2 == 0) ? "CHÍNH XÁC (ĐẠT)" : "CHƯA ĐẠT")

# --- 3. KIỂM TRA 5 CA BẮT BUỘC TRÊN PHIẾU HƯỚNG DẪN ---
println("\n" * "-"^75)
println("KIỂM TRA 5 CA BẮT BUỘC TRÊN PHIẾU HƯỚNG DẪN:")
println("-"^75)

cases = [
    ("Ca 1 (2 phần tử khác nhau)", [8, 2], 2, 8, 1, "Chỉ 1 phép so sánh giá trị"),
    ("Ca 2 (2 phần tử bằng nhau)", [4, 4], 4, 4, 1, "Vẫn chỉ 1 phép so sánh giá trị"),
    ("Ca 3 (Toàn số âm)", [-5, -1, -3], -5, -1, 3, "Không khởi tạo max bằng 0"),
    ("Ca 4 (n = 8, lũy thừa 2)", [1, 2, 3, 4, 5, 6, 7, 8], 1, 8, 10, "3*8/2 - 2 = 10 so sánh"),
    ("Ca 5 (n = 5, số lẻ)", [9, 1, 7, 3, 5], 1, 9, 6, "n lẻ, không ép công thức chẵn")
]

for (desc, a, exp_min, exp_max, exp_ss, note) in cases
    m, M, ss = giai_bai(a)
    _, _, ss_tt = min_max_truc_tiep(a)
    status = (m == exp_min && M == exp_max && ss == exp_ss) ? "PASS" : "FAIL"
    println("[$status] $desc")
    println("  Input   : $a")
    println("  Output  : min = $m, max = $M, số so sánh = $ss (Trực tiếp: $ss_tt so sánh)")
    println("  Ghi chú : $note")
end

println("\n" * "="^75)
println("HOÀN TẤT CHẠY DEMO TIẾN ĐỘ 1 CHO ĐỀ TÀI DT046!")
println("="^75)
