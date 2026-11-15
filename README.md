# Hafizh Portfolio

Portfolio publik satu halaman dan halaman arsip proyek. Aplikasi memakai Nuxt 4, Vue 3, JavaScript, dan CSS khusus. Konten dasar berasal dari profil GitHub serta situs portofolio lama yang dicantumkan di brief.

## Arah desain

- **Pembacaan desain:** portfolio developer personal untuk tim rekrutmen dan calon kolaborator, dengan bahasa editorial yang hangat. Dial: ENERGY 2 / RHYTHM 3 / MOTION 1.
- **Warna:** kertas `#FFFEFC` dan aprikot `#FFF8F3` menjaga bidang tetap hangat; tinta `#171717` dan teks `#626262` menjaga hirarki; oranye `#F36B21` memberi penanda identitas yang hemat.
- **Tipografi:** Manrope dipakai karena brief menyebutnya dan bentuknya mudah dibaca pada teks proyek.
- **Komposisi:** hero dua kolom memberi ruang pada nama dan foto. Bagian berikutnya berubah sesuai isi: narasi dan foto, daftar teknologi, proyek, pengalaman belajar, lalu urutan proses.
- **Kartu proyek:** menampilkan screenshot dan tautan nyata dalam satu unit agar orang dapat menilai karya dan membuka sumbernya.
- **Motif:** garis oranye tipis muncul sebagai penanda pada foto dan garis aktif navigasi. Ini mengikat halaman tanpa menjadikan seluruh elemen berwarna aksen.
- **Tema:** mode terang mengikuti palet dan arahan visual brief. Tidak ada toggle tema.
- **Gerak:** hanya interaksi hover, indikator aktif, dan scroll ke bagian. Animasi kompleks tidak diperlukan untuk alur baca ini.

## Struktur penting

```text
app/
  assets/css/main.css       Token, layout, responsive, dan fokus keyboard
  components/layout/        Navigasi dan footer bersama
  components/projects/      Kartu proyek
  composables/              Pemuatan data lokal atau Supabase
  data/portfolio.js         Konten portofolio yang dapat diedit
  layouts/default.vue       Kerangka halaman dan tautan skip
  pages/index.vue           Halaman Home
  pages/projects/index.vue  Arsip proyek dan filter kategori
public/images/              Foto dan screenshot proyek lokal
supabase/schema.sql         Tabel dan kebijakan baca publik
supabase/seed.sql           Konten proyek dan skill yang sudah terverifikasi
```

## Menjalankan lokal

Persyaratan: Node.js 22 atau lebih baru dan npm.

```bash
npm install
npm run dev
```

Buka alamat yang ditampilkan Nuxt di terminal. Untuk membuat build produksi:

```bash
npm run build
npm run preview
```

## Konten dan aset

Edit `app/data/portfolio.js` untuk nama, deskripsi, tautan, skill, dan proyek. Foto dan screenshot yang tersedia di repository portofolio lama disalin ke `public/images/`. Foto hero adalah foto pemilik dari repository tersebut, bukan foto orang acak.

Tiga proyek yang tercantum adalah Tracker.io, Web Portfolio lama, dan Landing Page GadgetFix. Detail judul, teknologi, dan tautan berasal dari halaman portofolio lama. Demo Netlify lama tidak berhasil dimuat saat pemeriksaan, jadi tautannya tetap tercantum sebagai tautan sumber yang diberikan, bukan demo yang sudah diverifikasi berjalan.

Tidak ada CV yang tersedia, jadi tombol unduh CV tidak ditampilkan. Kontak memakai alamat email publik terbaru dari profil GitHub. Tidak ada LinkedIn yang ditambahkan karena tidak ditemukan pada sumber yang diperiksa.

## Supabase

Tanpa kredensial, situs memakai `app/data/portfolio.js`. Koneksi membaca tabel `projects` dan `skills` ketika kedua variabel berikut tersedia:

```env
SUPABASE_URL=
SUPABASE_PUBLISHABLE_KEY=
```

Salin `.env.example` menjadi `.env`, lalu isi dengan Project URL dan publishable key dari Supabase. Publishable key boleh digunakan di klien sesuai pola Supabase. Jangan masukkan secret key atau service-role key ke aplikasi publik.

Jalankan `supabase/schema.sql` melalui SQL Editor Supabase, lalu jalankan `supabase/seed.sql` bila ingin mengisi contoh proyek dan skill yang bersumber dari portofolio. Row Level Security membatasi pembacaan pada konten yang diterbitkan atau ditampilkan. Hak tulis publik dicabut.

Supabase belum tersambung atau diuji karena kredensial tidak tersedia. Jika kueri gagal, aplikasi menampilkan konten lokal dan pesan status.

## Deploy ke Vercel

1. Buat repository GitHub dan push kode secara manual.
2. Import repository tersebut ke Vercel.
3. Biarkan Vercel mendeteksi Nuxt. Build command adalah `npm run build`.
4. Tambahkan `SUPABASE_URL` dan `SUPABASE_PUBLISHABLE_KEY` di pengaturan environment Vercel hanya setelah proyek Supabase tersedia.
5. Deploy preview, periksa kedua route, lalu atur domain khusus bila dibutuhkan.

Deployment belum dilakukan. Tidak ada konfigurasi DNS atau akun eksternal yang diubah.

## Catatan aset desain

Google Stitch project ID `14057915846124616864` dan empat screen ID ada di brief. Koneksi Google Stitch dan file export tidak tersedia di sesi ini. Implementasi mengikuti arahan tertulis, bukan pengukuran langsung terhadap screenshot Stitch. Screenshot Stitch masih diperlukan untuk pemeriksaan kesetiaan visual.

## Tahap berikutnya

Login admin, dashboard, CRUD, upload gambar, dan manajemen konten tetap ditunda sampai fase berikutnya. Tidak ada halaman login atau middleware autentikasi di fase ini.
