#!/home/user/Modèles/flutter/bin/dart

import 'dart:convert';
import 'dart:io';



class navBar {
  List<String> my_menu = ['Fichier', 'Commandes', 'Options', 'Infos'];
  int pos = 0;
  int box_size = 0;

  void user_select(String user_input) {
    List<int> element_encoded = user_input.codeUnits;
    if (element_encoded.length == 3) {  
      if (element_encoded[0] == 27 && element_encoded[1] == 91 && element_encoded[2] == 67) {
        pos = (pos + 1) % my_menu.length;
      }
      if (element_encoded[0] == 27 && element_encoded[1] == 91 && element_encoded[2] == 68) {
        pos = (pos - 1) % my_menu.length;
      }
    }
  }


  void display() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
    print("\x1B[2J\x1B[0;0H");
    int cpt_cursor = 0;
    String asterix;
    String space_between = "";
    for (String onglet in my_menu) {
      if (cpt_cursor == pos) {
        asterix = "\x1B[30;107m*";
      } else {
        asterix = " ";
      }
      space_between = " " * (box_size - onglet.length);
      stdout.write("$asterix$onglet\x1B[0m$space_between");
      cpt_cursor++;
    }
  }

  void debug(String user_input) {
    print('pos: $pos');
  }

  void set_box_size() {
    box_size = my_menu[0].length;
    for (String onglet in my_menu) {
      if (box_size < onglet.length) {
        box_size = onglet.length;
      }
    }
    box_size += 4;
  }

}

navBar my_bar = navBar();

void main() {
  //for (int i = 0; i < 5; i++) {
    //print('hello ${i + 1}');
  //}
  //String? name = stdin.readLineSync(); 
  //print("Hello, $name");


  //print("Input:");

  //my_bar.set_box_size();
  //my_bar.display();
  //stdin.echoMode = false;
  //stdin.lineMode = false;


  //stdin.transform(utf8.decoder).forEach((element) {

  /*
  stdin.transform(utf8.decoder).forEach((element) {
    List<int> element_encoded = element.codeUnits;
    print("Yep: $element = $element_encoded");
    if (element == "q") {
      print("EQUAL");
      stdin.cancel();
    }
  });*/

  int inputy;
  while (true) {
    inputy = getch();
    //print(inputy);
    if (inputy == 27) {
      inputy = getch();
      if (inputy == 91) {
        inputy = getch();
        if (inputy == 65) print("top arrow");
        if (inputy == 66) print("bottom arrow");
        if (inputy == 67) print("right arrow");
        if (inputy == 68) print("left arrow");
      }
    } else if (inputy == 113) { // == 'q'
      break;
    }
  }

  

   
  /*
  stdin.transform(utf8.decoder).forEach((element) {
    //List<int> element_encoded = element.codeUnits;
    //print("select: $element = $element_encoded");
    my_bar.user_select(element);
    //my_bar.debug(element);
    my_bar.display();
  });*/
}


int getch() {
  stdin.echoMode = false;
  stdin.lineMode = false;
  return stdin.readByteSync();
}