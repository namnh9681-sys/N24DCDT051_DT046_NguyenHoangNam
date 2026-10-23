using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

@testset "Bộ kiểm thử đề tài DT046 - Tìm đồng thời Min và Max (N24DCDT051)" begin

    @testset "1. Hai ví dụ trên phiếu đề tài" begin
        # VD01: Ví dụ 1
        res1 = giai_bai([-3, 7, 2, 9])
        @test res1 == (-3, 9, 4)

        # VD02: Ví dụ 2
        res2 = giai_bai([5])
        @test res2 == (5, 5, 0)
    end

    @testset "2. Năm ca kiểm tra bắt buộc trên phiếu hướng dẫn" begin
        # Ca 1: [8, 2] -> 1 so sánh
        @test giai_bai([8, 2]) == (2, 8, 1)

        # Ca 2: [4, 4] -> 1 so sánh
        @test giai_bai([4, 4]) == (4, 4, 1)

        # Ca 3: [-5, -1, -3] -> toàn âm, không khởi tạo max = 0
        @test giai_bai([-5, -1, -3]) == (-5, -1, 3)

        # Ca 4: [1, 2, 3, 4, 5, 6, 7, 8] -> n = 8, 3*8/2 - 2 = 10 so sánh
        @test giai_bai([1, 2, 3, 4, 5, 6, 7, 8]) == (1, 8, 10)

        # Ca 5: [9, 1, 7, 3, 5] -> n = 5 (lẻ), 6 so sánh
        @test giai_bai([9, 1, 7, 3, 5]) == (1, 9, 6)
    end

    @testset "3. Các ca tự thiết kế & kiểm thử đặc biệt" begin
        # TK01: Dãy giảm dần
        @test giai_bai([100, 50, 20, 10, 0, -10]) == (-10, 100, 8)

        # TK02: Toàn bộ phần tử bằng nhau n = 4
        @test giai_bai([7, 7, 7, 7]) == (7, 7, 4)

        # TK03: Mảng gồm 3 phần tử tăng dần
        @test giai_bai([10, 20, 30]) == (10, 30, 3)
    end

    @testset "4. Các ca kiểm thử giá trị biên" begin
        # BIEN01: Biên giá trị cực tiểu hợp lệ [-1000]
        @test giai_bai([-1000]) == (-1000, -1000, 0)

        # BIEN02: Biên giá trị cực đại và cực tiểu [-1000, 1000]
        @test giai_bai([-1000, 1000]) == (-1000, 1000, 1)

        # BIEN03: Biên độ dài tối đa n = 1024 (lũy thừa của 2: 3*1024/2 - 2 = 1534 so sánh)
        a_1024 = fill(0, 1024)
        a_1024[1] = -500
        a_1024[1024] = 500
        min_1024, max_1024, ss_1024 = giai_bai(a_1024)
        @test min_1024 == -500
        @test max_1024 == 500
        @test ss_1024 == 1534
    end

    @testset "5. Kiểm tra dữ liệu đầu vào không hợp lệ (Validator)" begin
        # LOI01: Mảng rỗng
        @test_throws ArgumentError kiem_tra_dau_vao(Int[])

        # LOI02: Độ dài vượt quá 1024
        @test_throws ArgumentError kiem_tra_dau_vao(fill(1, 1025))

        # LOI03: Phần tử vượt quá cận trên > 1000
        @test_throws ArgumentError kiem_tra_dau_vao([1, 2, 1001])

        # LOI04: Phần tử nhỏ hơn cận dưới < -1000
        @test_throws ArgumentError kiem_tra_dau_vao([-1001, 0, 5])

        # LOI05: Kiểu dữ liệu không phải vector
        @test_throws ArgumentError kiem_tra_dau_vao("khong_phai_mang")
    end

    @testset "6. Đối chiếu với thuật toán trực tiếp" begin
        test_arrays = [
            [-3, 7, 2, 9],
            [5],
            [8, 2],
            [4, 4],
            [-5, -1, -3],
            [1, 2, 3, 4, 5, 6, 7, 8],
            [9, 1, 7, 3, 5]
        ]
        for arr in test_arrays
            min_dc, max_dc, _ = giai_bai(arr)
            min_tt, max_tt, _ = min_max_truc_tiep(arr)
            @test min_dc == min_tt
            @test max_dc == max_tt
        end
    end

end
