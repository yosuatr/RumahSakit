import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  final judul = 'Cari Rumah Sakit';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: judul,
      home: HalamanUtama(title: judul),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  final String title;

  HalamanUtama({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Cari Rumah Sakit"),backgroundColor: Colors.blue[300]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget> [
            Image.asset("assets/abc.jpg"),
            RaisedButton(
              child: Text('MULAI CARI'),
              color: Colors.blue[300],
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cari()));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu.jpg'),
                  ),
                color: Colors.blue[300],
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              title: Text('Cari Rumah Sakit'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cari()));
              },
            ),
            ListTile(
              title: Text('Developer Contact'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Cari extends StatefulWidget {
  @override
  _CariState createState() => _CariState();
}

class _CariState extends State < Cari > {
  String valuegol;

  void pilihan() {
   setState(() {
      if (valuegol == '1') {
       Navigator.push(context, MaterialPageRoute(builder: (context) => Mata()));
      } else if (valuegol == '2') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Jantung()));
      } else if (valuegol == '3') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => THT()));
      } else if (valuegol == '4') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Kulit()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Rumah Sakit',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(35.0),
          child: Form(
            child: Column(
              children:[
                Center(
                  child: DropdownButton < String > (
                    items: [
                      DropdownMenuItem < String > (
                        child: Text('Mata'),
                        value: '1',),
                      DropdownMenuItem < String > (
                        child: Text('Jantung'),
                        value: '2', ),
                      DropdownMenuItem < String > (
                        child: Text('THT'),
                        value: '3', ),
                      DropdownMenuItem < String > (
                        child: Text('Kulit'),
                        value: '4', ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        valuegol = value;
                      });
                    },
                    hint: Text('Pilih Kategori'),
                    value: valuegol,
                  ),
                ),
                Container(height: 10.0),
                RaisedButton(
                  color: Colors.blue[300],
                  child: Text('Cari'),
                  onPressed: () {
                      pilihan();
                  }, ),
              ]
            ),
          )
        ),
      )
    );
  }
}


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State < ContactUs > {
  GlobalKey < FormState > _formkey = GlobalKey < FormState > ();
  String submit = '';
  final myControllerNama = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPesan = TextEditingController();
  @override

  void dispose() {
    myControllerNama.dispose();
    myControllerEmail.dispose();
    myControllerPesan.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(35.0),
          child: Form(
            key: _formkey,
            child: Column(
              children:[
                TextFormField(
                  controller: myControllerNama,
                  validator: (value) => (myControllerNama.text.isEmpty) ? 'Nama tidak boleh dikosongkan' : null,
                  decoration: InputDecoration(
                    hintText: 'Masukan Nama',
                    labelText: 'Nama',
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                Container(height: 10.0),

                TextFormField(
                  controller: myControllerEmail,
                  decoration: InputDecoration(
                    hintText: 'email@Gmail.com',
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    Pattern pattern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return 'Email Anda tidak valid';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                Container(height: 10.0),

                TextFormField(
                  controller: myControllerPesan,
                  validator: (value) => (myControllerPesan.text.isEmpty) ? 'Pesan tidak boleh dikosongkan' : null,
                  decoration: InputDecoration(
                    hintText: 'Masukan Pesan',
                    labelText: 'Pesan',
                    icon: Icon(Icons.message),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                Container(height: 10.0),

                RaisedButton(
                  color: Colors.blue,
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) =>
                        HalamanKonfirmasi(
                          nama: myControllerNama.text,
                          email: myControllerEmail.text,
                          pesan: myControllerPesan.text,
                        ),
                      );
                      Navigator.of(context).push(route);
                    }
                  },
                ),
                Text(this.submit),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class HalamanKonfirmasi extends StatefulWidget {
  final String nama;
  final String email;
  final String pesan;

  HalamanKonfirmasi({
    Key key,
    this.nama,
    this.email,
    this.pesan
  }): super(key: key);

  @override
  _HalamanKonfirmasiState createState() => _HalamanKonfirmasiState();
}

class _HalamanKonfirmasiState extends State < HalamanKonfirmasi > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Konfirmasi'),
      ),
      body: Column(
        children:[
          Container(height: 35.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Nama: ${widget.nama}'),
            ], ),
          Container(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Email: ${widget.email}'),
            ], ),
          Container(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Pesan: ${widget.pesan}'),
            ], )
        ]
      ),
    );
  }
}

class Mata extends StatefulWidget {
  @override
  _MataState createState() => _MataState();
}

class _MataState extends State<Mata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Rumah Sakit Mata',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Jakarta Eye Center Menteng"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => JakartaEyeCenter(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("AINI Eye Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => AINIEyeHospital(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Primasana Eye Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => PrimasanaEyeHospital(),
                ),
              );
            },
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("RS Mata SMEC Tebet"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => RSMataSMECTebet(),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}


class Jantung extends StatefulWidget {
  @override
  _JantungState createState() => _JantungState();
}

class _JantungState extends State<Jantung> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Rumah Sakit Jantung',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("RS Harapan Kita"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => RSHarapanKita(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Jakarta Heart Center"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => JakartaHeartCenter(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Binawaluya Heart Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => BinawaluyaHeartHospital(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Pertamina Central Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => PertaminaCentralHospital(),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}

class THT extends StatefulWidget {
  @override
  _THTState createState() => _THTState();
}

class _THTState extends State<THT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Rumah Sakit THT',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView(
        children: <Widget>[ 
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Dr. Suyoto Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SuyotoHospital(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Medika Permata Hijau Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => MedikaPermataHijauHospital(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Siloam Hospitals Kebon Jeruk"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SiloamHospitalsKebonJeruk(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Bhakti Mulia Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => BhaktiMuliaHospital(),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}

class Kulit extends StatefulWidget {
  @override
  _KulitState createState() => _KulitState();
}

class _KulitState extends State<Kulit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Rumah Sakit Kulit',
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue[300],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Spesialis Kulit Dan Kelamin RS Gandaria"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SpesialisKulitDanKelaminRSGandaria(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("RSUP Nasional dr. Cipto Mangunkusumo"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => CiptoMangunkusumo(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Jakarta Hospital"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => JakartaHospital(),
                ),
              );
            },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Rumah Sakit St. Carolus"),
              trailing: Icon(Icons.add_location),
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Carolus(),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}


class JakartaEyeCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.198526, 106.836829),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class AINIEyeHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.218757, 106.816808),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class PrimasanaEyeHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.114102, 106.889741),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class RSMataSMECTebet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.228959, 106.847220),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



class RSHarapanKita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.185438, 106.798729),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class JakartaHeartCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.200208, 106.855292),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class BinawaluyaHeartHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.306996, 106.870584),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class PertaminaCentralHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.238924, 106.793306),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class SuyotoHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.268001, 106.766306),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class MedikaPermataHijauHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.217391, 106.777870),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class SiloamHospitalsKebonJeruk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.190002, 106.763602),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class BhaktiMuliaHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.198663, 106.800423),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class SpesialisKulitDanKelaminRSGandaria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.243123, 106.790379),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class CiptoMangunkusumo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.196455, 106.846741),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class JakartaHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.218379, 106.816133),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class Carolus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text("Maps"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.195465, 106.851370),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Home()));
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue[300],
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}