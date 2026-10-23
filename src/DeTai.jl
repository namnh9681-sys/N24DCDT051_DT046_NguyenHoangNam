module DeTai

export kiem_tra_dau_vao, min_max, min_max_truc_tiep, dem_so_sanh, giai_bai

"""
    kiem_tra_dau_vao(a)

Kiểm tra tính hợp lệ của mảng đầu vào theo phiếu đề tài DT046:
- Mảng `a` không được rỗng và có độ dài từ 1 đến 1024 phần tử.
- Các phần tử phải là số nguyên nằm trong khoảng [-1000, 1000].
Trả về `true` nếu hợp lệ, ném `ArgumentError` nếu dữ liệu vi phạm quy ước.
"""
function kiem_tra_dau_vao(a)
    if !(a isa AbstractVector)
        throw(ArgumentError("Dữ liệu đầu vào phải là một mảng một chiều (Vector)"))
    end
    n = length(a)
    if n == 0
        throw(ArgumentError("Mảng không được rỗng (độ dài tối thiểu là 1)"))
    end
    if n > 1024
        throw(ArgumentError("Độ dài mảng không được vượt quá 1024 phần tử (hiện tại: $n)"))
    end
    for (idx, val) in enumerate(a)
        if !(val isa Integer)
            throw(ArgumentError("Phần tử tại vị trí $idx không phải số nguyên: $val"))
        end
        if val < -1000 || val > 1000
            throw(ArgumentError("Phần tử tại vị trí $idx ($val) nằm ngoài phạm vi cho phép [-1000, 1000]"))
        end
    end
    return true
end

"""
    min_max(a, l, r)

Tìm đồng thời giá trị nhỏ nhất và lớn nhất trong đoạn `a[l:r]` bằng kỹ thuật chia để trị.
Trả về bộ 3 giá trị: `(min_val, max_val, so_sanh)`
- Cơ sở 1: l == r (1 phần tử) -> min = max = a[l], số phép so sánh = 0.
- Cơ sở 2: r == l + 1 (2 phần tử) -> so sánh 1 lần giữa a[l] và a[r], số phép so sánh = 1.
- Chia đôi: m = (l + r) ÷ 2, gọi đệ quy trên 2 nửa [l:m] và [m+1:r].
- Ghép: 1 so sánh giữa hai min và 1 so sánh giữa hai max -> tăng đúng 2 phép so sánh.
Tổng số phép so sánh của bước đệ quy: c1 + c2 + 2.
"""
function min_max(a, l, r)
    # Cơ sở 1: Đoạn có đúng 1 phần tử
    if l == r
        return (a[l], a[l], 0)
    end

    # Cơ sở 2: Đoạn có đúng 2 phần tử
    if r == l + 1
        if a[l] <= a[r]
            return (a[l], a[r], 1)
        else
            return (a[r], a[l], 1)
        end
    end

    # Chia để trị: Chia đôi đoạn chỉ số
    m = (l + r) ÷ 2
    nho1, lon1, c1 = min_max(a, l, m)
    nho2, lon2, c2 = min_max(a, m + 1, r)

    # Ghép 2 nửa: 1 phép so giữa 2 min, 1 phép so giữa 2 max
    min_val = nho1 <= nho2 ? nho1 : nho2
    max_val = lon1 >= lon2 ? lon1 : lon2
    so_sanh_merge = 2

    return (min_val, max_val, c1 + c2 + so_sanh_merge)
end

"""
    min_max_truc_tiep(a)

Tìm min và max bằng phương pháp duyệt tuần tự trực tiếp (so sánh mỗi phần tử
với cả min và max hiện tại), tốn 2n - 2 phép so sánh khi n >= 2 (hoặc 0 khi n == 1).
Dùng để đối chiếu hiệu quả số phép so sánh với phương pháp chia để trị.
"""
function min_max_truc_tiep(a)
    kiem_tra_dau_vao(a)
    n = length(a)
    if n == 1
        return (a[1], a[1], 0)
    end

    min_val = a[1]
    max_val = a[1]
    so_sanh = 0

    for i in 2:n
        so_sanh += 1
        if a[i] < min_val
            min_val = a[i]
        end

        so_sanh += 1
        if a[i] > max_val
            max_val = a[i]
        end
    end

    return (min_val, max_val, so_sanh)
end

"""
    dem_so_sanh(a)

Hàm tiện ích giải bài toán tìm min, max và trả về số so sánh theo chia để trị.
"""
function dem_so_sanh(a)
    kiem_tra_dau_vao(a)
    return min_max(a, 1, length(a))
end

"""
    giai_bai(du_lieu)

Hàm chuẩn theo khung đồ án cá nhân: nhận dữ liệu vào, kiểm tra hợp lệ
và thực thi thuật toán chia để trị giải đề tài DT046.
"""
function giai_bai(du_lieu)
    kiem_tra_dau_vao(du_lieu)
    return min_max(du_lieu, 1, length(du_lieu))
end

end # module DeTai
