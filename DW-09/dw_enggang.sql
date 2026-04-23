CREATE TABLE dim_waktu (
    sk_waktu SERIAL PRIMARY KEY,
    tanggal DATE,
    bulan INTEGER,
    nama_bulan VARCHAR(20),
    kuartal INTEGER,
    tahun INTEGER
);

CREATE TABLE dim_toko (
    sk_toko SERIAL PRIMARY KEY,
    store_id VARCHAR(50),
    nama_toko VARCHAR(100),
    kota VARCHAR(100),
    tipe_toko VARCHAR(50)
);

CREATE TABLE dim_pelanggan (
    sk_pelanggan SERIAL PRIMARY KEY,
    customer_id VARCHAR(50) UNIQUE,
    nama_lengkap VARCHAR(100),
    kota_domisili VARCHAR(100)
);

CREATE TABLE dim_produk (
    sk_produk SERIAL PRIMARY KEY,
    product_id VARCHAR(50) UNIQUE,
    kategori VARCHAR(100),
    nama_produk VARCHAR(100)
);

CREATE TABLE dim_kurir (
    sk_kurir SERIAL PRIMARY KEY,
    nama_kurir VARCHAR(100)
);

CREATE TABLE fact_sales (
    sk_waktu_transaksi INTEGER,
    sk_toko INTEGER,
    sk_pelanggan INTEGER,
    sk_produk INTEGER,
    transaction_id VARCHAR(50),
    qty INTEGER,
    subtotal_harga DECIMAL(18,2),

    FOREIGN KEY (sk_waktu_transaksi) REFERENCES dim_waktu(sk_waktu),
    FOREIGN KEY (sk_toko) REFERENCES dim_toko(sk_toko),
    FOREIGN KEY (sk_pelanggan) REFERENCES dim_pelanggan(sk_pelanggan),
    FOREIGN KEY (sk_produk) REFERENCES dim_produk(sk_produk)
);

CREATE TABLE fact_target_sales (
    sk_waktu INTEGER,
    sk_toko INTEGER,
    target_pendapatan_rp DECIMAL(18,2),

    FOREIGN KEY (sk_waktu) REFERENCES dim_waktu(sk_waktu),
    FOREIGN KEY (sk_toko) REFERENCES dim_toko(sk_toko)
);

CREATE TABLE fact_delivery (
    sk_waktu_sampai INTEGER,
    sk_toko INTEGER,
    sk_kurir INTEGER,
    transaction_id VARCHAR(50),
    status_pengiriman VARCHAR(50),
    durasi_hari INTEGER,
    biaya_ongkir DECIMAL(18,2),

    FOREIGN KEY (sk_waktu_sampai) REFERENCES dim_waktu(sk_waktu),
    FOREIGN KEY (sk_toko) REFERENCES dim_toko(sk_toko),
    FOREIGN KEY (sk_kurir) REFERENCES dim_kurir(sk_kurir)
);