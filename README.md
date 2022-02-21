# Analisis Data Boston Crime Tahun 2015-2019
Rasa aman merupakan salah satu perasaan terpenting yang perlu untuk dimiliki oleh setiap orang. Berdasarkan penelitian, perasaan aman memiliki korelasi positif terhadap tingkat harapan hidup seseorang (Arora, et al., 2016). Apabila dikaitkan dengan kondisi lingkungan, lingkungan yang memiliki tingkat kriminalitas tinggi tentu tidak akan membuat para warganya merasa aman untuk tinggal di daerah tersebut.

Boston merupakan ibukota dari negara bagian Massachussets, sekaligus merupakan kota dengan tingkat populasi terbanyak ke-21 di Amerika Serikat dengan populasi tidak kurang dari 695.000 jiwa. Sebagai ibukota dengan jumlah populasi yang tidak sedikit, kota Boston menjadi suatu kota yang tidak dapat lepas dari tindak kriminalitas. Dilansir dari situs Alarms.org, didapatkan data bahwa dari sebanyak 150 kota yang terdapat di negara bagian Massachussets, kota Boston berada pada peringkat 130 untuk indeks kemanan kota di Amerika Serikat. Hal inilah yang menjadi dasar dilakukannya penelitian terhadap tingkat kejahatan di kota Boston selama 5 tahun terakhir.

Data kejahatan di kota Boston selama tahun 2015-2019 merupakan suatu dataset yang memberikan informasi mengenai setiap insiden yang dilaporkan kepada pihak kepolisian Boston. Dataset ini mengandung beberapa variabel berikut:

1. Incident_Number
2. Offense_Code
3. Offense_Code_Group
4. Offense_Description
5. District
6. Reporting_Area
7. Shooting
8. Occurred_On_Date
9. Year
10. Month
11. Day_Of_Week 12. Hour
13. UCR_Part
14. Street
15. Lat
16. Long
17. Location

Sebelum melakukan proses analisis terhadap data kejahatan di kota Boston selama 5 tahun terakhir, data mentah yang didapatkan sebelumnya perlu untuk dibersihkan terlebih dahulu melalui proses data preprocessing. Berikut merupakan langkah-langkah data preprocessing terhadap dataset Boston crime:

1. Memasukkan dataset Boston crime pada IDE R dengan query read.csv(), lalu melihat summary dari data tersebut

- Terdapat banyak kejahatan dengan Incident_Number yang sama. Pada awalnya, diasumsikan bahwa Incident_Number merupakan atribut unik yang tidak mungkin memiliki duplikat. Setelah dilakukan penelusuran lebih lanjut, didapat bahwa satu Incident_Number memungkinkan untuk mengandung beberapa kejahatan yang
berbeda. Salah satu contohnya adalah kejadian dengan Incident_Number I52071596 yang memiliki 20 duplikat data. Setelah ditelusuri lebih lanjut, ditemukan bahwa pada laporan kejadian tersebut terdapat 5 Offense_Code_Group berbeda yang terjadi (umumnya menunjukkan 5 kejadian / kejahatan berbeda yang terjadi). Masing- masing Offense_Code_Group juga berduplikasi sebanyak 3 kali. Hal ini kemungkinan menunjukkan bahwa terdapat 4 orang berbeda yang melaksanakan tindak kejahatan tersebut. Pada analisis ini, data yang akan digunakan hanyalah data 5 Offense_Code_Group berbeda yang terjadi pada insiden tersebut. Sedangkan 3 data duplikasi lainnya akan dibuang.

- Terdapat banyak missing data, hal ini akan terlihat lebih jelas pada tahapan ke-4 dari data preprocessing

2. Menangani duplicate data dengan query unique()
Query unique() digunakan untuk menghapus data yang memiliki values setiap kolom yang persis sama. Hal ini dilakukan untuk mengatasi kasus yang sejenis dengan insiden nomor I52071596 yang telah dijelaskan pada bagian sebelumnya.

3. Mengubah seluruh blank cells menjadi NA
Pada data mentah Boston crime, terdapat sebagian missing values yang bernilai NA dan sebagian lagi hanya berupa blank space. Seluruh blank space akan diubah menjadi NA agar memudahkan tahapan selanjutnya dari data preprocessing.


