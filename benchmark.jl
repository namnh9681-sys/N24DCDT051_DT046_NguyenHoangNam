# benchmark.jl - Đo đạc thực nghiệm trên các quy mô n in {5, 20, 100, 500}
include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Random
using Printf

Random.seed!(42)

println("="^95)
println("KẾT QUẢ ĐO ĐẠC THỰC NGHIỆM ĐỀ TÀI DT046 TRÊN CÁC QUY MÔ DỮ LIỆU:")
println("So sánh số phép so sánh và thời gian giữa Chia để trị và Duyệt trực tiếp")
println("="^95)
@printf("%-8s | %-16s | %-14s | %-14s | %-12s | %-14s\n", 
        "Quy mô", "Chia để trị (ss)", "Trực tiếp (ss)", "Tiết kiệm (ss)", "Tỷ lệ giảm", "Thời gian (ns)")
println("-"^95)

scales = [5, 20, 100, 500]
for n in scales
    a = rand(-1000:1000, n)
    
    # Warmup
    min_max(a, 1, n)
    min_max_truc_tiep(a)
    
    # Measure time
    N_RUNS = 10000
    t0 = time_ns()
    for _ in 1:N_RUNS
        min_max(a, 1, n)
    end
    t_cd = (time_ns() - t0) / N_RUNS

    min_cd, max_cd, ss_cd = min_max(a, 1, n)
    min_tt, max_tt, ss_tt = min_max_truc_tiep(a)
    tiet_kiem = ss_tt - ss_cd
    pct = round(tiet_kiem / ss_tt * 100, digits=2)

    @printf("n = %-4d | %-16d | %-14d | %-14d | %-11.2f%% | %-10.1f ns\n", 
            n, ss_cd, ss_tt, tiet_kiem, pct, t_cd)
end
println("="^95)
