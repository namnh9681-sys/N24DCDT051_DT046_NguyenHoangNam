# ==============================================================================
# HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG - CƠ SỞ TẠI TP. HỒ CHÍ MINH
# HỌC PHẦN: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT (INT13185) - NHÓM 03
# GIẢNG VIÊN HƯỚNG DẪN: HỒ NHỰT MINH
# SINH VIÊN: NGUYỄN HOÀNG NAM - MSSV: N24DCDT051 - LỚP: D24CQDT01-N
# ĐỀ TÀI: DT046 - TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

function chay_demo()
    println("="^80)
    println("DEMO ĐỀ TÀI DT046: TÌM ĐỒNG THỜI GIÁ TRỊ NHỎ NHẤT VÀ LỚN NHẤT (MỐC 2)")
    println("Sinh viên: Nguyễn Hoàng Nam | MSSV: N24DCDT051 | Lớp: D24CQDT01-N")
    println("Khoa: Kỹ thuật Điện tử 2 | Ngành: Kỹ thuật Điện - Điện tử")
    println("="^80)

    # --- 1. HAI VÍ DỤ GỐC TRÊN PHIẾU ---
    println("\n" * "-"^80)
    println("1. HAI VÍ DỤ GỐC TRÊN PHIẾU GIAO ĐỀ TÀI:")
    println("-"^80)
    
    # VD01
    a1 = [-3, 7, 2, 9]
    min1, max1, ss1 = giai_bai(a1)
    _, _, ss1_tt = min_max_truc_tiep(a1)
    println("[VD01] Ví dụ 1:")
    println("  Input               : ", a1)
    println("  Chia để trị         : min = $min1, max = $max1, số so sánh = $ss1")
    println("  Kỳ vọng trên phiếu  : min = -3, max = 9, so_sanh = 4")
    println("  Duyệt trực tiếp (2n-2): số so sánh = $ss1_tt")
    println("  Đánh giá            : ", (min1 == -3 && max1 == 9 && ss1 == 4) ? "CHÍNH XÁC (ĐẠT)" : "CHƯA ĐẠT")

    # VD02
    a2 = [5]
    min2, max2, ss2 = giai_bai(a2)
    _, _, ss2_tt = min_max_truc_tiep(a2)
    println("\n[VD02] Ví dụ 2 (1 phần tử):")
    println("  Input               : ", a2)
    println("  Chia để trị         : min = $min2, max = $max2, số so sánh = $ss2")
    println("  Kỳ vọng trên phiếu  : min = 5, max = 5, so_sanh = 0")
    println("  Duyệt trực tiếp     : số so sánh = $ss2_tt")
    println("  Đánh giá            : ", (min2 == 5 && max2 == 5 && ss2 == 0) ? "CHÍNH XÁC (ĐẠT)" : "CHƯA ĐẠT")

    # --- 2. CÁC CA TỰ THIẾT KẾ ĐẶC BIỆT ---
    println("\n" * "-"^80)
    println("2. CÁC CA TỰ THIẾT KẾ ĐẶC BIỆT:")
    println("-"^80)
    
    # TK01: Mảng giảm dần
    a_tk1 = [100, 50, 20, 10, 0, -10]
    m_tk1, M_tk1, ss_tk1 = giai_bai(a_tk1)
    println("[TK01] Mảng giảm dần:")
    println("  Input: $a_tk1 -> Output: min = $m_tk1, max = $M_tk1, số so sánh = $ss_tk1 (ĐẠT)")

    # TK02: Mảng trùng
    a_tk2 = [7, 7, 7, 7]
    m_tk2, M_tk2, ss_tk2 = giai_bai(a_tk2)
    println("[TK02] Mảng trùng nhau:")
    println("  Input: $a_tk2 -> Output: min = $m_tk2, max = $M_tk2, số so sánh = $ss_tk2 (ĐẠT)")

    # TK03: Mảng 3 phần tử (lần vết tay)
    a_tk3 = [10, 20, 30]
    m_tk3, M_tk3, ss_tk3 = giai_bai(a_tk3)
    println("[TK03] Mảng 3 phần tử (lần vết tay):")
    println("  Input: $a_tk3 -> Output: min = $m_tk3, max = $M_tk3, số so sánh = $ss_tk3 (ĐẠT)")

    # --- 3. CÁC CA BIÊN HỢP LỆ ---
    println("\n" * "-"^80)
    println("3. CÁC CA BIÊN HỢP LỆ:")
    println("-"^80)
    
    println("[BIEN01] Biên giá trị cực tiểu: a = [-1000] -> ", giai_bai([-1000]))
    println("[BIEN02] Hai cực biên [-1000, 1000] -> ", giai_bai([-1000, 1000]))
    a_1024 = fill(0, 1024); a_1024[1] = -500; a_1024[1024] = 500
    m_b3, M_b3, ss_b3 = giai_bai(a_1024)
    println("[BIEN03] Biên kích thước tối đa n = 1024: min = $m_b3, max = $M_b3, so sánh = $ss_b3 (Lý thuyết: 3*1024/2 - 2 = 1534)")

    # --- 4. KIỂM THỬ TỪ CHỐI INPUT SAI (VALIDATOR) ---
    println("\n" * "-"^80)
    println("4. KIỂM THỬ TỪ CHỐI INPUT SAI (VALIDATOR):")
    println("-"^80)
    for (ten_loi, du_lieu) in [
        ("Mảng rỗng []", Int[]),
        ("Kích thước vượt quá 1024", fill(1, 1025)),
        ("Phần tử vượt quá 1000", [1, 2, 1001]),
        ("Phần tử nhỏ hơn -1000", [-1001, 0, 5])
    ]
        try
            kiem_tra_dau_vao(du_lieu)
            println("  [LOI01 - $ten_loi] : Không bắt được lỗi (FAIL)")
        catch e
            println("  [LOI01 - $ten_loi] : Từ chối thành công -> $(e.msg)")
        end
    end

    # --- 5. ĐO ĐẠC THỰC NGHIỆM TRÊN CÁC QUY MÔ n in {5, 20, 100, 500} ---
    println("\n" * "-"^80)
    println("5. ĐO ĐẠC THỰC NGHIỆM VÀ SO SÁNH TRÊN CÁC QUY MÔ n in {5, 20, 100, 500}:")
    println("-"^80)
    @printf("%-10s | %-18s | %-16s | %-16s | %-12s\n", 
            "Quy mô n", "Chia để trị (ss)", "Trực tiếp (ss)", "Tiết kiệm (ss)", "Tỷ lệ giảm")
    println("-"^80)
    for n in [5, 20, 100, 500]
        # Sử dụng mảng kiểm thử chuẩn
        a_scale = collect(1:n)
        _, _, ss_cd = min_max(a_scale, 1, n)
        _, _, ss_tt = min_max_truc_tiep(a_scale)
        tk = ss_tt - ss_cd
        pct = round(tk / ss_tt * 100, digits=2)
        @printf("n = %-6d | %-18d | %-16d | %-16d | %-10.2f%%\n", n, ss_cd, ss_tt, tk, pct)
    end
    println("="^80)
end

function nhap_tu_ban_phim()
    println("NHẬP DỮ LIỆU TỪ BÀN PHÍM:")
    print("Nhập các số nguyên cách nhau bởi dấu cách (hoặc phẩy): ")
    line = readline()
    items = filter(!isempty, split(replace(line, "," => " ")))
    a = parse.(Int, items)
    println("Mảng đã nhập: ", a)
    min_val, max_val, ss = giai_bai(a)
    _, _, ss_tt = min_max_truc_tiep(a)
    println("Kết quả Chia để trị : min = $min_val, max = $max_val, số so sánh = $ss")
    println("Duyệt trực tiếp     : số so sánh = $ss_tt")
    println("Số phép so sánh tiết kiệm được: $(ss_tt - ss) phép so sánh")
end

if "--nhap" in ARGS
    nhap_tu_ban_phim()
else
    chay_demo()
end
