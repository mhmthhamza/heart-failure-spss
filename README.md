# Kalp Yetmezliği Hastalarında Mortaliteyle İlişkili Klinik Faktörler (SPSS)

299 kalp yetmezliği hastasında, takip sırasında ölen ve hayatta kalan hastaların hangi klinik özelliklerde farklılaştığını inceleyen bir biyoistatistik projesi. Analizlerin tamamı IBM SPSS Statistics 26'da, tek bir syntax dosyasıyla yapıldı ve baştan sona tekrar çalıştırılabiliyor.

**Rapor:** [report/rapor.pdf](report/rapor.pdf) (Türkçe, APA 7)

## Araştırma soruları

1. Ölen ve hayatta kalan hastalar klinik ölçümlerde (yaş, ejeksiyon fraksiyonu, serum kreatinin, serum sodyum, CPK, trombosit) farklı mı?
2. Kategorik özellikler (yaş grubu, EF grubu, cinsiyet, sigara, anemi, diyabet, yüksek tansiyon) ölümle ilişkili mi?
3. Klinik ölçümler yaş gruplarına ve EF gruplarına göre farklılaşıyor mu?

## Ana bulgular

- Hastaların 96'sı (%32.1) takip sırasında öldü.
- **En büyük fark serum kreatininde:** Ölen hastalarda medyan 1.30 mg/dL, hayatta kalanlarda 1.00 mg/dL (Mann-Whitney *U* = 5298, *p* < .001, *r* = .37).
- **Ölen hastalarda ejeksiyon fraksiyonu daha düşük** (medyan %30 ve %38, *r* = .29). Ölen hastalar ayrıca daha yaşlı (*r* = .22) ve serum sodyumları daha düşük (*r* = .21).
- **Yaş grubu ölümle ilişkili tek kategorik değişken:** Ölüm oranı 60 yaş altında %24.0, 70 yaş ve üstünde %49.4 (χ²(2) = 14.77, *p* < .001, *V* = .22). Cinsiyet, sigara, anemi, diyabet ve yüksek tansiyon ölümle ilişkili bulunmadı.
- **EF gruplandığında fark kayboluyor:** Sürekli EF güçlü bir fark gösterirken ESC 2021 kılavuzuna göre oluşturulan EF grupları ölümle anlamlı ilişki göstermedi (*p* = .172). Bunun başlıca nedeni hastaların %73'ünün ≤%40 grubunda toplanması.

## Yöntem

| Adım | Yöntem |
| --- | --- |
| Normallik | Shapiro-Wilk, Q-Q grafikleri ve kutu grafikleri. Tüm sürekli değişkenlerde en az bir grupta *p* < .05 çıktığı için parametrik olmayan testler seçildi. |
| Ölen ve hayatta kalanların karşılaştırması | Mann-Whitney *U*, etki büyüklüğü *r* = \|*Z*\| / √*N* |
| Kategorik değişkenler | Pearson ki-kare, etki büyüklüğü Cramér's *V* |
| Yaş ve EF gruplarına göre karşılaştırma | Kruskal-Wallis *H*, ikili karşılaştırmalar için Bonferroni düzeltmeli Dunn testi, etki büyüklüğü η²H |
| Çoklu test | Ham *p* değerleri raporlandı ve Bonferroni eşikleri ayrıca belirtildi. Anlamlı çıkan tüm sonuçlar bu eşiklerin altında. |

Yaş grupları <60, 60–69 ve 70+ olarak; EF grupları ise ESC 2021 kılavuzuna göre ≤40, 41–49 ve ≥50 olarak oluşturuldu. Kesim noktaları sonuçlara bakılmadan belirlendi.

## Nasıl çalıştırılır

1. Repoyu indir veya klonla.
2. SPSS'te `syntax/heart_failure_analysis.sps` dosyasını aç.
3. Dosyanın başındaki `CD` satırında klasör yolunu kendi bilgisayarındaki yolla değiştir:
   ```
   CD 'C:\...\heart-failure-spss'.
   ```
4. **Run > All** ile çalıştır. Çıktı `output/` klasörüne hem `.spv` hem `.pdf` olarak kaydedilir.

Syntax dosyası UTF-8 (BOM'lu) olarak kaydedildi. Klasör yolunda Türkçe karakter varsa ve SPSS `CD` satırında hata verirse, klasörü adında Türkçe karakter bulunmayan bir yere taşıman yeterli (örneğin `C:\heart-failure-spss`).

## Klasör yapısı

```
heart-failure-spss/
├── data/      heart_failure_clinical_records.csv (ham veri, UCI)
│              heart_failure.sav (SPSS'e aktarılmış, etiketli veri)
├── syntax/    heart_failure_analysis.sps (analizin tamamı)
├── output/    heart_failure_output.spv, heart_failure_output.pdf
├── report/    rapor.docx, rapor.pdf
└── README.md
```

## Veri

Veri seti UCI Machine Learning Repository'deki [Heart Failure Clinical Records](https://archive.ics.uci.edu/dataset/519/heart-failure-clinical-records) seti. Veriler Pakistan'ın Faisalabad kentindeki Institute of Cardiology and Allied Hospital'da Nisan–Aralık 2015 arasında izlenen hastalardan toplandı. Veri setinde 40 yaş ve üzeri, NYHA sınıf III–IV olan 299 hasta (105 kadın, 194 erkek) ve 13 değişken var. Eksik veri yok, takip süresi 4 ile 285 gün arasında.

Kaynak gösterimi:

- Chicco, D., & Jurman, G. (2020). Machine learning can predict survival of patients with heart failure from serum creatinine and ejection fraction alone. *BMC Medical Informatics and Decision Making, 20*, 16. https://doi.org/10.1186/s12911-020-1023-5
- Ahmad, T., Munir, A., Bhatti, S. H., Aftab, M., & Raza, M. A. (2017). Survival analysis of heart failure patients: A case study. *PLOS ONE, 12*(7), e0181001. https://doi.org/10.1371/journal.pone.0181001

## Sınırlılıklar

- Takip süreleri farklı (4–285 gün) ama bu analizler takip süresini hesaba katmıyor. Takipten erken çıkan bir hasta daha sonra ölmüş olabilir.
- Analizlerin hepsi tek değişkenli. Örneğin kreatinin yaşla da artıyor, bu yüzden yaşın ve kreatininin etkileri birbirinden ayrılamıyor.
- Veriler gözlemsel; bulunan ilişkiler nedensellik göstermiyor.

## Sonraki adım (v2)

Değişkenlerin bağımsız etkilerini görmek için lojistik regresyon ve ROC analizi eklenecek.
