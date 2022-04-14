#!/home/user/Modèles/flutter/bin/dart

import 'dart:convert';
import 'dart:io';

class navBar {
  List<String> my_menu = ['Fichier', 'Commandes', 'Options', 'Infos'];

  List<String> sub_menu_fichier = ['F1', 'F2', 'F3'];

  List<String> selected_menu = [''];
  List<String> previous_selected_menu = [''];
  int previous_pos = 0;

  int pos = 0;
  int menu_level = 0;
  int box_size = 0;

  void user_select(int user_input) {
    pos = (pos + user_input) % selected_menu.length;
  }

  void display() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
    print("\x1B[2J\x1B[0;0H");
    int cpt_cursor = 0;
    String asterix;
    String space_between = "";
    print("'q' to quit");
    for (String onglet in selected_menu) {
      if (cpt_cursor == pos) {
        asterix = "\x1B[30;107m*";
      } else {
        asterix = " ";
      }
      space_between = " " * (box_size - onglet.length);
      stdout.write("$asterix$onglet\x1B[0m$space_between");
      cpt_cursor++;
    }
    print("\x1B[5;0H");
  }

  void debug() {
    print('pos: $pos');
  }

  int quit_menu() {
    if (menu_level==0) {
      return -1;
    } else {
      selected_menu = previous_selected_menu;
      pos = previous_pos;
      menu_level--;
      return menu_level;
    }
  }

  void const_refresh() {
    menu_level++;
    previous_pos = pos;
    pos = 0;
  }

  void reset_box(bool init) {
    if (init) {
      selected_menu = my_menu;
      previous_selected_menu = my_menu;
    } else {
      switch (selected_menu[pos]) {
        case 'Fichier':
          selected_menu = sub_menu_fichier;
          const_refresh();
          break;
        case 'Commandes':
          selected_menu = sub_menu_fichier;
          const_refresh();
          break;
        case 'Options':
          selected_menu = sub_menu_fichier;
          const_refresh();
          break;
        case 'Infos':
          selected_menu = sub_menu_fichier;
          const_refresh();
          break;
      }
    }
    reset_size();
  }

  void reset_size() {
    box_size = selected_menu[0].length;
    for (String onglet in selected_menu) {
      if (box_size < onglet.length) {
        box_size = onglet.length;
      }
    }
    box_size += 2;
  }
}

navBar my_bar = navBar();

void main() {
  my_bar.reset_box(true);
  my_bar.display();

  int inputy;
  while (true) {
    inputy = getch();
    print(inputy);
    if (inputy == 27) {
      inputy = getch();
      if (inputy == 91) {
        inputy = getch();
        // if (inputy == 65) print("top arrow");
        // if (inputy == 66) print("bottom arrow");
        if (inputy == 67) {
          my_bar.user_select(1);
          // print("right arrow");
        }
        if (inputy == 68) {
          my_bar.user_select(-1);
          // print("left arrow");
        }
      }
    } else if (inputy == 10) { // == 'enter'
      my_bar.reset_box(false);
    } else if (inputy == 113) { // == 'q'
      if (my_bar.quit_menu() == -1) {
        print(Process.runSync("clear", [], runInShell: true).stdout);
        break;
      }
      my_bar.reset_size();
    }
    my_bar.display();
    // my_bar.debug();
  }
}

int getch() {
  stdin.echoMode = false;
  stdin.lineMode = false;
  return stdin.readByteSync();
}