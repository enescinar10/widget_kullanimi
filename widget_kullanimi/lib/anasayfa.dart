import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget{
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String alinanVeri = "";
  var tfControl = TextEditingController(); // textfieldan text kontrolü
  String resimAdi = "baklava.png";
  bool switchKontrol = false;
  bool checkboxKontrol = false;
  int radioDeger = 0;
  bool progressKontrol = false;
  double ilerleme = 30.0;
  var tfSaat = TextEditingController();
  var tfTarih = TextEditingController();
  var ulkelerListesi = <String>[];
  String secilenUlke = "Türkiye";

  @override
  void initState() {
    super.initState();
    ulkelerListesi.add("Türkiye");
    ulkelerListesi.add("İtalya");
    ulkelerListesi.add("Japonya");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Widget Kullanımı"),
      ) ,
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(alinanVeri),
              Padding(
                padding: const EdgeInsets.only(left: 32.0 , right: 32.0),
                child: TextField(
                  controller:tfControl ,
                  decoration: const InputDecoration(hintText: "Veri"),
                  keyboardType: TextInputType.number, // sayısal bi klavye
                  obscureText: true, // şifre girer gibi gösterir
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  alinanVeri = tfControl.text;
                });
              }, child: const Text("OKU")),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      resimAdi = "kofte.png";
                    });
                  }, child: const Text("Resim-1")),
                  //Image.asset("resimler/$resimAdi"), // lokal resimler
                  SizedBox(width: 72, height: 72,
                      child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/$resimAdi")), // internetten resimler
                  ElevatedButton(onPressed: (){
                    setState(() {
                      resimAdi = "ayran.png";
                    });
                  }, child: const Text("Resim-2")),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 200, // buan width vermez isek liste boyutu aşar tasarımımız görülmez.
                    child: SwitchListTile(
                      title: const Text("Dart"),
                        controlAffinity: ListTileControlAffinity.leading , // soldamı sağdamı olacak gözükecek
                        value: switchKontrol, // true - false olunca sonuc verecek
                        onChanged: (veri){
                        setState(() {
                          switchKontrol = veri;
                        });
                        }
                    ),
                  ),
                  SizedBox(width: 200,
                    child: CheckboxListTile(
                      title: const Text("Flutter"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: checkboxKontrol,
                        onChanged: (veri){
                          setState(() {
                            checkboxKontrol = veri!;
                          });
                        }
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 200,
                    child: RadioListTile(
                        title: const Text("Barcelona"),
                        value: 1, // bunun idsi
                        groupValue: radioDeger,
                        onChanged: (veri){
                          setState(() {
                            radioDeger = veri!;
                          });
                        }
                    ),
                  ),
                  SizedBox(width: 200,
                    child: RadioListTile(
                        title: const Text("Real Madrid"),
                        value: 2, // bunun idsi
                        groupValue: radioDeger,
                        onChanged: (veri){
                          setState(() {
                            radioDeger = veri!;
                          });
                        }
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      progressKontrol = true;
                    });
                  }, child: const Text("Başla")),
                  Visibility( visible: progressKontrol,child: const CircularProgressIndicator()),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      progressKontrol = false;
                    });
                  }, child: const Text("Dur")),
                ],
              ),
              Text(ilerleme.toInt().toString()),
              Slider(max: 100.0 , min: 0.0, value: ilerleme, onChanged: (veri){
                setState(() {
                  ilerleme = veri;
                });
              }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 120,
                      child: TextField(controller: tfSaat,decoration: const InputDecoration(hintText: "Saat"),)),
                  IconButton(onPressed: (){
                    showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()))
                        .then((value){
                          tfSaat.text = "${value!.hour}  : ${value.minute}";  // seçtiğimiz saat verisi textfield a aktarılır.
                    });
                  }, icon: const Icon(Icons.access_time)),
                  SizedBox(width: 120,
                      child: TextField(controller: tfTarih,decoration: const InputDecoration(hintText: "Tarih"),)),
                  IconButton(onPressed: (){
                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2030)).then((value){
                      tfTarih.text = "${value!.day} / ${value.month} / ${value.year}";
                    });
                  }, icon: const Icon(Icons.date_range)),
                ],
              ),
              DropdownButton(
                value: secilenUlke,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  items: ulkelerListesi.map((ulke){
                    return DropdownMenuItem(value: ulke , child: Text(ulke),);
                  }).toList(),
                  onChanged: (veri){
                  setState(() {
                    secilenUlke = veri!;
                  });
                  }),
              GestureDetector(
                  onTap:(){
                    print("Container Tek tıklandı");
                  } ,
                  onDoubleTap: (){
                    print("Çift Tıklandı");
                  },
                  onLongPress: (){
                    print("Container üzerine uzun basıldı.");
                  },
                  child: Container(width: 200, height: 100,color: Colors.red,)), // bu yapıyı tıklanabilir yapar
              ElevatedButton(onPressed: (){
                print("Switch durum : $switchKontrol");
                print("CheckBox Durum : $checkboxKontrol");
                print("Radio durum : $radioDeger");
                print("Slider Durum : $ilerleme");
                print("Seçilen Ülke : $secilenUlke");
              }, child: const Text("Göster")),
            ],
          ),
        ),
      ) ,
    );
  }
}
