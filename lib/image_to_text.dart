import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:translator/translator.dart';

class MyImage extends StatefulWidget {
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  File pickedImage = File("");
  var text = '';
  String translatedText;
  bool imageLoaded = false;
  String language;
  bool hasData;
  static final langs = [
    'Afrikaans',
    'Albanian',
    'Amharic',
    'Arabic',
     'Armenian',
     'Azerbaijani',
     'Basque',
     'Belarusian',
     'Bengali',
     'Bosnian',
     'Bulgarian',
     'Catalan',
     'Cebuano',
     'Chichewa',
     'Chinese Simplified',
     'Chinese Traditional',
     'Corsican',
     'Croatian',
     'Czech',
     'Danish',
     'Dutch',
     'English',
     'Esperanto',
     'Estonian',
     'Filipino',
     'Finnish',
     'French',
     'Frisian',
     'Galician',
     'Georgian',
     'German',
     'Greek',
     'Gujarati',
     'Haitian Creole',
     'Hausa',
     'Hawaiian',
     'Hebrew',
     'Hindi',
     'Hmong',
     'Hungarian',
     'Icelandic',
     'Igbo',
     'Indonesian',
     'Irish',
     'Italian',
     'Japanese',
     'Javanese',
     'Kannada',
     'Kazakh',
     'Khmer',
     'Korean',
     'Kurdish (Kurmanji)',
     'Kyrgyz',
     'Lao',
     'Latin',
     'Latvian',
     'Lithuanian',
     'Luxembourgish',
     'Macedonian',
     'Malagasy',
     'Malay',
     'Malayalam',
     'Maltese',
     'Maori',
     'Marathi',
     'Mongolian',
     'Myanmar (Burmese)',
     'Nepali',
     'Norwegian',
     'Pashto',
     'Persian',
     'Polish',
     'Portuguese',
     'Punjabi',
     'Romanian',
     'Russian',
     'Samoan',
     'Scots Gaelic',
     'Serbian',
     'Sesotho',
     'Shona',
     'Sindhi',
     'Sinhala',
     'Slovak',
     'Slovenian',
     'Somali',
    'Spanish',
     'Sundanese',
     'Swahili',
     'Swedish',
     'Tajik',
     'Tamil',
     'Telugu',
     'Thai',
     'Turkish',
     'Ukrainian',
     'Urdu',
     'Uzbek',
     'Uyghur',
     'Vietnamese',
    'Welsh',
     'Xhosa',
     'Yiddish',
     'Yoruba',
     'Zulu'
  ]; 
  static final m = {
    'auto': 'Automatic',
    'af': 'Afrikaans',
    'sq': 'Albanian',
    'am': 'Amharic',
    'ar': 'Arabic',
    'hy': 'Armenian',
    'az': 'Azerbaijani',
    'eu': 'Basque',
    'be': 'Belarusian',
    'bn': 'Bengali',
    'bs': 'Bosnian',
    'bg': 'Bulgarian',
    'ca': 'Catalan',
    'ceb': 'Cebuano',
    'ny': 'Chichewa',
    'zh-cn': 'Chinese Simplified',
    'zh-tw': 'Chinese Traditional',
    'co': 'Corsican',
    'hr': 'Croatian',
    'cs': 'Czech',
    'da': 'Danish',
    'nl': 'Dutch',
    'en': 'English',
    'eo': 'Esperanto',
    'et': 'Estonian',
    'tl': 'Filipino',
    'fi': 'Finnish',
    'fr': 'French',
    'fy': 'Frisian',
    'gl': 'Galician',
    'ka': 'Georgian',
    'de': 'German',
    'el': 'Greek',
    'gu': 'Gujarati',
    'ht': 'Haitian Creole',
    'ha': 'Hausa',
    'haw': 'Hawaiian',
    'iw': 'Hebrew',
    'hi': 'Hindi',
    'hmn': 'Hmong',
    'hu': 'Hungarian',
    'is': 'Icelandic',
    'ig': 'Igbo',
    'id': 'Indonesian',
    'ga': 'Irish',
    'it': 'Italian',
    'ja': 'Japanese',
    'jw': 'Javanese',
    'kn': 'Kannada',
    'kk': 'Kazakh',
    'km': 'Khmer',
    'ko': 'Korean',
    'ku': 'Kurdish (Kurmanji)',
    'ky': 'Kyrgyz',
    'lo': 'Lao',
    'la': 'Latin',
    'lv': 'Latvian',
    'lt': 'Lithuanian',
    'lb': 'Luxembourgish',
    'mk': 'Macedonian',
    'mg': 'Malagasy',
    'ms': 'Malay',
    'ml': 'Malayalam',
    'mt': 'Maltese',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mn': 'Mongolian',
    'my': 'Myanmar (Burmese)',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'ps': 'Pashto',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'pa': 'Punjabi',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sm': 'Samoan',
    'gd': 'Scots Gaelic',
    'sr': 'Serbian',
    'st': 'Sesotho',
    'sn': 'Shona',
    'sd': 'Sindhi',
    'si': 'Sinhala',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'so': 'Somali',
    'es': 'Spanish',
    'su': 'Sundanese',
    'sw': 'Swahili',
    'sv': 'Swedish',
    'tg': 'Tajik',
    'ta': 'Tamil',
    'te': 'Telugu',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'uz': 'Uzbek',
    'ug': 'Uyghur',
    'vi': 'Vietnamese',
    'cy': 'Welsh',
    'xh':'Xhosa',
    'yi':'Yiddish',
    'yo':'Yoruba',
    'zu':'Zulu'
  };


  var out;
  GoogleTranslator translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();

  

  void speak() async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(1);
    await flutterTts.speak(out.toString());
  }

   Future pickImage(ImageSource imageSource) async {
    var awaitImage = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });

   }

    void trans()async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    for (TextBlock block in visionText.blocks) {
      text = '';
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();
    print("Translate Images");

    String translateTo =
        m.keys.firstWhere((k) => m[k] == language, orElse: () => null);
    print(translateTo);
    translator.translate(text, to: translateTo).then((output) {
      setState(() {
        out = output;
        hasData=true;
      });
    });
  
    
  }

  @override
  void initState() {
    super.initState();
    hasData = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Image to Text Translation")),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          imageLoaded
              ? Center(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 20),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  height: 250,
                  width: 250,
                  child: Image.file(
                    pickedImage,
                    fit: BoxFit.cover,
                  ),
                ))
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 20),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Icon(
                    Icons.image,
                    size: 150,
                  ),
                ),
          SizedBox(height: 10.0),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.photo_camera,
                    size: 50,
                  ),
                  label: Text(''),
                  textColor: Colors.teal,
                  onPressed: () async {
                   pickImage(ImageSource.camera);
                  },
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.photo,
                    size: 50,
                  ),
                  label: Text(''),
                  textColor: Colors.teal,
                  onPressed: () async {
                    pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ButtonTheme(
            alignedDropdown: true,
           child: DropdownButton(
              hint: Text("Select Language for Translation"),
              value: language,
              onChanged: (value) {
                setState(() {
                  language = value;
                });
              },
              items:langs.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
          ),
          FlatButton(
                onPressed:
                    (language != null && text != null) ? trans : null,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Translate"),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                        width: size.width/2,
                        child: out!=null?Text(
                            out.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ):Text(""),
                      ),                  
                   Container(
                      child: out != null?
                      Positioned(
                        top: 0,
                        child: FlatButton(
                              onPressed: speak, child: Icon(Icons.volume_up)
                        ),
                      ): Text(""),
                      )
                ],
              )
        ],
      ),
    ));
  }
}
