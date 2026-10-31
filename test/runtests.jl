using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

@testset "Bộ kiểm thử toàn diện đề tài DT046 - Tìm đồng thời Min và Max (N24DCDT051)" begin

    # --- NHÓM 1: HAI VÍ DỤ GỐC TRÊN PHIẾU GIAO ĐỀ TÀI ---
    @testset "Ca 1 (VD01): Ví dụ 1 trên phiếu [-3, 7, 2, 9]" begin
        res1 = giai_bai([-3, 7, 2, 9])
        @test res1 == (-3, 9, 4)
        @test res1[1] == -3
        @test res1[2] == 9
        @test res1[3] == 4
    end

    @testset "Ca 2 (VD02): Ví dụ 2 trên phiếu [5] (Mảng 1 phần tử)" begin
        res2 = giai_bai([5])
        @test res2 == (5, 5, 0)
        @test res2[1] == 5
        @test res2[2] == 5
        @test res2[3] == 0
    end

    # --- NHÓM 2: CÁC CA TỰ THIẾT KẾ ĐẶC BIỆT ---
    @testset "Ca 3 (TK01): Mảng giảm dần [100, 50, 20, 10, 0, -10]" begin
        res3 = giai_bai([100, 50, 20, 10, 0, -10])
        @test res3 == (-10, 100, 8)
    end

    @testset "Ca 4 (TK02): Mảng toàn bộ phần tử trùng nhau [7, 7, 7, 7]" begin
        res4 = giai_bai([7, 7, 7, 7])
        @test res4 == (7, 7, 4)
    end

    # --- NHÓM 3: CÁC CA KIỂM THỬ GIÁ TRỊ BIÊN ---
    @testset "Ca 5 (BIEN01): Biên giá trị cực tiểu [-1000]" begin
        @test giai_bai([-1000]) == (-1000, -1000, 0)
    end

    @testset "Ca 6 (BIEN02): Hai cực biên đối lập [-1000, 1000]" begin
        @test giai_bai([-1000, 1000]) == (-1000, 1000, 1)
    end

    @testset "Ca 7 (BIEN03): Dữ liệu lớn quy mô tối đa n = 1024" begin
        a_1024 = fill(0, 1024)
        a_1024[1] = -500
        a_1024[1024] = 500
        min_1024, max_1024, ss_1024 = giai_bai(a_1024)
        @test min_1024 == -500
        @test max_1024 == 500
        @test ss_1024 == 1534  # 3*1024/2 - 2 = 1534 phép so sánh
    end

    # --- NHÓM 4: KIỂM THỬ INPUT KHÔNG HỢP LỆ (VALIDATOR) ---
    @testset "Ca 8 (LOI01): Input sai - Mảng rỗng và vi phạm ràng buộc" begin
        # Mảng rỗng
        @test_throws ArgumentError kiem_tra_dau_vao(Int[])
        # Vượt quá kích thước tối đa 1024
        @test_throws ArgumentError kiem_tra_dau_vao(fill(1, 1025))
        # Phần tử vượt cận trên > 1000
        @test_throws ArgumentError kiem_tra_dau_vao([1, 2, 1001])
        # Phần tử nhỏ hơn cận dưới < -1000
        @test_throws ArgumentError kiem_tra_dau_vao([-1001, 0, 5])
        # Kiểu dữ liệu không phải vector
        @test_throws ArgumentError kiem_tra_dau_vao("chuoi_ky_tu")
    end

    # --- NHÓM 5: NĂM CA BẮT BUỘC TRÊN PHIẾU HƯỚNG DẪN ---
    @testset "Ca 9 (KT09): Ca bắt buộc 1 - Mảng 2 phần tử [8, 2]" begin
        @test giai_bai([8, 2]) == (2, 8, 1)
    end

    @testset "Ca 10 (KT10): Ca bắt buộc 3 - Mảng toàn số âm [-5, -1, -3]" begin
        @test giai_bai([-5, -1, -3]) == (-5, -1, 3)
    end

    @testset "Ca 11 (KT11): Ca bắt buộc 4 - Dãy n = 8 lũy thừa 2 [1..8]" begin
        @test giai_bai([1, 2, 3, 4, 5, 6, 7, 8]) == (1, 8, 10)
    end

    @testset "Ca 12 (KT12): Ca bắt buộc 5 - Mảng độ dài lẻ n = 5 [9, 1, 7, 3, 5]" begin
        @test giai_bai([9, 1, 7, 3, 5]) == (1, 9, 6)
    end

    # --- CÁC CA MỞ RỘNG VÀ ĐỐI CHIẾU ---
    @testset "Ca bổ sung: Mảng 3 phần tử phục vụ lần vết tay [10, 20, 30]" begin
        @test giai_bai([10, 20, 30]) == (10, 30, 3)
    end

    @testset "Đối chiếu toàn diện với thuật toán duyệt trực tiếp" begin
        test_samples = [
            [-3, 7, 2, 9],
            [5],
            [8, 2],
            [4, 4],
            [-5, -1, -3],
            [1, 2, 3, 4, 5, 6, 7, 8],
            [9, 1, 7, 3, 5],
            [100, 50, 20, 10, 0, -10],
            [7, 7, 7, 7],
            [10, 20, 30]
        ]
        for arr in test_samples
            min_cd, max_cd, _ = giai_bai(arr)
            min_tt, max_tt, _ = min_max_truc_tiep(arr)
            @test min_cd == min_tt
            @test max_cd == max_tt
        end
    end

end
