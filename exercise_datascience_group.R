# Day 1 IMPORT DATA ====

#Part A Setting directory-------------
## Sebelumnya setting tempat penyimpanan default untuk Rstudio
## Untuk itu kita harus tahu dimana folder  penyimpanan default untuk saat ini
getwd() #mencari tahu dimana dokumen disimpan
setwd("D:/Bhakti/Data personal/9. R Studio/02. Input Data") #Merubah folder penyimpanan (disesuaikan dengan folder masing-masing)

## Part B Load data dari CSV-----------
## data akan disimpan dalam kedalam sebuah variabel misalnya saya kasih nama df
df.1 <- read.csv("PROD_EQUINOR.csv") # jika directory sudah diarahkan ke folder tempat saya menyimpan file PROD_EQUINOR.csv (ingat untuk memberikan tanda petik)
df.2 <- read.csv("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.csv") # jika mau mengambil pada folder lain. (ingat garis miring ke kanan / )
df.3 <- read.csv("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.csv", header = FALSE) # jika saya anggap header pada data adalah termasuk kedalam data
## secara default header adalah TRUE


##Part C load data dari .txt ---------
df.4 <- read.delim("EQUINOR.txt")

## Part D load data dari clipboard-----------
df.5 <- read.table(file = "clipboard")

## Part E load data dengan memilih filenya langsung-----------
df.6 <- read.csv(file.choose())

## Part F load data dari EXCEL----------------------
## gunakan library excel, sebelumnya install dulu
install.packages("readxl") ## install packages
library(readxl) #panggil library nya

df.7 <- read_excel("PROD_EQUINOR.xlsx", sheet = 1)
df.8 <- read_excel("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.xlsx", sheet = 1) # kalau mau ambil dari sheet 1
df.9 <- read_excel("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.xlsx", sheet = "PROD_EQUINOR") # cara lain
df.10 <- read_excel("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.xlsx", sheet = 2, range = "A1:D10") #Membaca dari range tertentu

##Part G menyimpan data--------------
write.csv(df.9, file = "TEST_SAVE.csv") #Menyimpan ke CSV
write.table(df.9, file = "TEST_SAVE.txt") # Menyimpan ke .txt
write.table(df.9, file = "TEST_SAVE2.txt", sep = ":") # separator dalam :
saveRDS(df.9, "DF9") #menyimpan dalam format R


## Part H menghapus data 
df.9 <- NULL


## Part i ------------
#perhatikan jika datanya cukup rumit, gunakan format ini, atau search pada help read.csv
#read.csv(file, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, comment.char = "") 


##Part k ------------
##membuat data sendiri
x<- c("a", "B", "C")
y<- 1:3
z <- 6:8
xyz <- data.frame(x,y,z)


##Part k -----------
# data overview
head(df.1) ## melihat 6 data teratas
head(df.1, 20) ## melihat 20 data teratas
tail(df.1) ## melihat 6 data terbawah
tail(df.1, 10) ## melihat 10 data terbawah
View(df.1) #Melihat semuanya
names(df.1) ##cek nama kolomnya
str(df.1) ## cek struktur data
summary(df.1) ## melihat statistik data frame

##=========================================================

##Days 2 Tidy data ================
## Untuk merapikan data akan digunakan library(tidyverse)
install.packages("tidyverse")
library(tidyverse)
##Library tidy verse itu sangat lengkap karena merupakan kumpulan dari banyak library yang sering digunakan untuk merapikan data, satu kali install tidyverse sama dengan install berikut
install.packages(c("ggplot2","tibble", "tidyr", "readr", "purrr", "stringr", "forcats"))
library(ggplot2)
library(tibble)
library(tidyr)
library(readr)
library(purrr)
library(stringr)
library(forcats)

##Part A ------------
#merapikan nama kolom
xyz <- data.frame(x=c("A", "B", "C"), y=1:3, z=4:6) #Membuat tabel sederhana
view(xyz) #melihat tabel
colnames(xyz) <- c("NAMA","NILAI", "KELAS") #Mengganti seluruh nama, jangan lupa meletakkan tanda " "
view(xyz) #melihat tabel
colnames(xyz)[3]<-"GRADE" #jika hanya ingin mengganti nama kolom ketiga saja
colnames(xyz)[c(1,3)]<-c("ABJAD","GRADE") #Mengganti dua kolom, jangan lupa meletakkan c(), c adalah compillation
view(xyz) #melihat tabel

##Part B ------------
#Na Values, bekerja dengan data yang hilang
m <- matrix(sample(c(NA, 1:10), 100, replace = TRUE), 10) #Contoh data
d <- data.frame(m) #Masih lanjutan membuat data
d #melihat data di console, rekomended hanya untuk data ukuran kecil
is.na(d) #mencari tahu apakah ada data yang hilang
d[is.na(d)] <- 0 #Mengganti nilai NA dengan 0
d
d[d==0] <- 10000 #Misal disini saya ingin mengganti setiap yang bernilai 0 menjadi 1000
d
d[d >= 100] <- "Na" #Menjadikan nilai anomali menjadi Na
d


##Part B ------------
#vlookup
##Persiapan data----
all.states <- as.data.frame(state.x77) ##Membuat data dari database Rstudio
all.states$Name <- rownames(state.x77) ##Membuat data dari database Rstudio
rownames(all.states) <- NULL ##Membuat data dari database Rstudio
str(all.states) ##Membuat data dari database Rstudio

### Membuat dataset pertama menjadi negara bagian dingin

cold.states <- all.states[all.states$Frost>150, c("Name", "Frost")]
cold.states

### Membuat dataset pertama menjadi negara yang cukup luas

large.states <- all.states[all.states$Area>=100000, c("Name", "Area")]
large.states

##Vlookup dengan syntax yang simple saja merge()---------
merge(cold.states, large.states, all=TRUE) #Semua yang unik masuk
merge(cold.states, large.states, all=FALSE) #yang sama aja yang masuk

##Part C ------------
#Tipe data, data dapat berupa numeric (integer, double), character... pada perhitungan harus numeric, untuk penamaan hasus character
xyz <- data.frame(x=c("A", "B", "C"), y=1:3, z=4:6) #Membuat tabel sederhana
xyz$A <- as.double(c(1.000, 3.234, 4.111)) #Floating point banyak harus menggunakan format double
str(xyz) #Melihat struktur data
xyz$x <- as.character(xyz$x) #Mengganti struktur menjadi karakter
str(xyz)
##Kasus lain adalah factor , apa itu faktor
hari <- c("Senin", "Selasa", "Rabu", "Kamis", "Jumat") #Contoh membuat dara
sort(hari) #Urutannya adalah sesuai abjad, saya mau mengurutkan sesuai level hari nya
urutan <- c("Senin","Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu") #Membuat urutan
y <- factor(hari, levels = urutan) #Mengurutkan sesuai levelnya
y 
##Kasus lain yang berhubungan dengan date
##Pada tahapan ini gunakan library(lubridate) dan library(nycflights13)
install.packages("lubridate")
install.packages("nycflights13")
library(lubridate) #Untuk tanggal 
library(nycflights13) #Dataset tentang penerbangan di USA

today() #Cek tanggal hari ini
head(flights) #cek data yang baru di unduh
df.11 <- flights
TAHUN <- year(df.11$time_hour) #Mengambil tahunnya doang
head(TAHUN) #Cek
BULAN <- month(df.11$time_hour) #Mengambil tahunnya doang
head(BULAN)
MENIT <- minute(df.11$time_hour)
head(MENIT)


##===================================================================
##Day 3=======================
## data transformation

#Part A-------
##menggabungkan data dari banyak data
## data yang akan digunakan adalah data newyork city flight
## data ini terdiri dari 4 data tabel yang saling berkatan isinya
library(nycflights13)
str(flights) #Tabel ini adalah bagian dari library(nycflights13)
str(airlines) #Tabel ini adalah bagian dari library(nycflights13)
str(airports) #Tabel ini adalah bagian dari library(nycflights13)
str(planes) #Tabel ini adalah bagian dari library(nycflights13)
str(weather) #Tabel ini adalah bagian dari library(nycflights13)

##menggabungkan dua data dengan kesamaan di dalamnya, misalnya flight dengan planes mempunyai kesamaan dibagian tailnum (nomor ekor pesawat)
str(flights) #cek 
str(planes) #cek

df13 <- merge(flights, planes, all = F) #2 objek telah bergabung menjadi satu tabel
##cara lain menggunkan library tydyverse atau dplyr
library(tidyverse)
df14 <- left_join(flights, airlines, by = "carrier") #menggabungkan dua tabel berdasarkan jenis angkutan
df15 <- left_join(df14, planes, by = "tailnum") #Menggabungkan tiga tabel berdasarkan angkutan dan nomor ekor pesawat
## DTS... tergantung objek apa yang mau di gabungkan


#PartB---------
## Menggunakan dplyr untuk pengolahan data
##Sebenarnya dplyr sudah ada dalam tidyverse, tapi disini saya coba panggil lagi supaya lebih jelas bahwa operasi disini menggunakan bagian dplyr
library(dplyr)
df_trans <- read.csv("D:/Bhakti/Data personal/9. R Studio/02. Input Data/PROD_EQUINOR.csv") #Tabel utama
str(df_trans)
##PART B1 - Fungsi select()
df_trans_2 <- select(df_trans, DATEPRD, WELL_BORE_CODE) #jika hanya ingin mengambil dua kolom saja dari tabel utama
df_trans_3 <- select(df_trans, DATEPRD:NPD_FACILITY_CODE) #mengambil kolom antara DATEPRD sampai NPD_FACILITY_CODE
df_trans_4 <- select(df_trans, DATEPRD,AVG_DP_TUBING,BORE_OIL_VOL,NPD_FIELD_NAME) #mengambil beberapa bagian kolom (tidak harus berurutan)
df_trans_5 <- select(df_trans, -FLOW_KIND) #Membuang kolom flow kind
df_trans_6 <- select(df_trans, -(DP_CHOKE_SIZE:FLOW_KIND)) #Membuang kolom DP_CHOKE sampi flow kind
df_trans_7 <- select(df_trans, WELL_TYPE, everything()) #memindahkan WELL TYPE menjadi urutan pertama
df_trans_8 <- select(df_trans,  ends_with("VOL")) #hanya kolom dengan nama akhir VOL saja yang di pilih
df_trans_9 <- select(df_trans, starts_with("AVG")) #Hanya kolom dengan nama awal AVG saja yang dipilih
##PART B2 - Fungsi filter()
df_trans_10 <- filter(df_trans, BORE_OIL_VOL >10) # Melakukan filter data yang lebih dari 10 BBL
df_trans_11 <- filter(df_trans, BORE_OIL_VOL > 10 & BORE_GAS_VOL >200) # dua kondisi filter
##PART B3 - Fungsi arrange()
df_trans_12 <- arrange(df_trans, DP_CHOKE_SIZE) #mengurutkan dari nilai choke terkecil
df_trans_13 <- arrange(df_trans, desc(DP_CHOKE_SIZE)) #Desc() berarti descending, dari yang terbesar ke yang terkecil
##PART B4 - Fungsi rename()
df_trans_14 <- rename(df_trans, tanggal=DATEPRD) # merubah nama kolom
##PART B5 - Fungsi mutate()
df_trans_15 <- mutate(df_trans, WATERCUT = BORE_WAT_VOL/(BORE_OIL_VOL+BORE_WAT_VOL)) #Membuat kolom baru dari hasil perhitungan kolom eksisting
##PART B6 - Fungsi group_by()
df_trans_16 <- group_by(df_trans, NPD_WELL_BORE_NAME) #melakukan grouping terhadap nama sumur
summarize(df_trans_16, OIL=sum(BORE_OIL_VOL), GAS=sum(BORE_GAS_VOL), WATER=sum(BORE_WAT_VOL)) # try this, its amazing

##Menggunakan pipe %>%, artinya adalah melanjutkan perintah selanjutnya
data_summary <- df_trans %>% 
  select(DATEPRD,NPD_WELL_BORE_NAME, BORE_OIL_VOL:BORE_WI_VOL) %>% 
  group_by(NPD_WELL_BORE_NAME) %>% summarize(OIL=sum(BORE_OIL_VOL), GAS=sum(BORE_GAS_VOL), WATER=sum(BORE_WAT_VOL))

##Coba plotting
library(ggplot2)
ggplot(data = data_summary, aes(x=NPD_WELL_BORE_NAME, y=OIL)) + #data dan axis
  geom_bar(stat="identity", width=0.5, fill="#69b3a2")  + #Jenis plot geom bar, ukuran dan kode warna
  ggtitle("CUM OIL ~ VOLVE FIELD") + #Judul
  theme(legend.position="bottom") #Template

##================================================================
##Data visualization
library(tidyverse)
df <- read.csv(file.choose()) ## data US OIL

##Plot produksi tiap states (Wilayah)
AK <- df %>% 
  group_by(state,prod_year) %>% 
  summarize(WELLSOIL=sum(num_oil_wells),
            WELLSGAS=sum(num_gas_wells),
            OILPROD=sum(oil_prod_BBL),
            GASPROD=sum(ADgas_prod_MCF))

ggplot(AK, aes(state)) + 
  geom_line(aes(prod_year, OILPROD, colour=state)) + 
  facet_wrap(vars(state)) +
  scale_y_log10() + ggtitle("OIL PROD / STATES") + ylab("STB/D") + theme_bw()

## Plot produksi total
AB <- df  %>% 
  group_by(prod_year) %>% 
  summarize(WELLSOIL=sum(num_oil_wells),
            WELLSGAS=sum(num_gas_wells),
            OILPROD=sum(oil_prod_BBL),
            GASPROD=sum(ADgas_prod_MCF))
ggplot(AB, aes(prod_year)) + 
  geom_line(aes(prod_year, OILPROD)) +
  scale_y_log10() + ggtitle("OIL PROD / STATES") + ylab("STB/D") + theme_bw()

ggplot(AK, aes(state)) + 
  geom_line(aes(prod_year, GASPROD, colour=state)) + 
  facet_wrap(vars(state)) +
  scale_y_log10() + ggtitle("GAS PROD / STATES") + ylab("MSCF/D") + theme_bw()
ggplot(AK, aes(state)) + 
  geom_line(aes(prod_year, WELLSOIL, colour=state)) + 
  facet_wrap(vars(state)) +
  ggtitle("WELL OIL / STATES") + ylab("MSCF/D") + theme_bw() +scale_y_log10()
ggplot(AK, aes(state)) + 
  geom_line(aes(prod_year, WELLSGAS, colour=state)) + 
  facet_wrap(vars(state)) +
  ggtitle("WELL GAS / STATES") + ylab("NUMBER WELL") + theme_bw() +scale_y_log10()
##------------------
##Dari one petro (Mr. Alfonso Reyes)
install.packages("petro.One")
library(petro.One)
library(tidyverse)
major   <- c("steam")
results_steam <- run_papers_search(major, 
                                   get_papers = TRUE,       # return with papers
                                   verbose = FALSE,         # show progress
                                   len_keywords = 4,        # naming the data file
                                   allow_duplicates = FALSE) # by paper title and id
papers_steam <- results_steam$papers
papers_steam %>% 
  group_by(year) %>% 
  na.omit() %>% 
  summarize(n = n()) %>% 
  {. ->> papers_steam_by} %>% 
  ggplot(., aes(x = year, y = n)) +
  geom_point() +
  geom_smooth(method = "loess") +
  labs(title = "Paper Steam on ONEPETRO") +theme_bw()+scale_y_log10()
