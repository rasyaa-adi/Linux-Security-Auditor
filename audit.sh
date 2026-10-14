
#!/bin/bash

mkdir -p reports
laporan="reports/audit-$(date +%Y-%m-%d_%H-%M-%S).txt"

{
    echo "======================================"
    echo "        LINUX SECURITY AUDITOR"
    echo "======================================"
    echo "User: $(whoami)"
    echo "Tanggal: $(date)"

    for file in catatan.txt rahasia.txt; do
        echo ""
        echo "File: $file"

        if [ ! -f "$file" ]; then
            echo "File tidak ditemukan"
            continue
        fi

        permission=$(stat -c "%a" "$file")
        echo "Permission: $permission"

        if [ -w "$file" ]; then
            echo "Akses user saat ini: Bisa menulis"
        else
            echo "Akses user saat ini: Tidak bisa menulis"
        fi

        if find "$file" -maxdepth 0 -perm /022 -print -quit | grep -q .; then
               echo "PERINGATAN: Grup atau pengguna lain memiliki izin tulis"
        else
           echo " Status: Tidak ada izin tulis untuk Grup/pengguna lain"
        fi
    done

    echo ""
    echo "Audit selesai."
} | tee "$laporan"

echo ""
echo "Laporan tersimpan di: $laporan"
