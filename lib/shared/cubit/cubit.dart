import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../archivedTask/view.dart';
import '../../doneTask/view.dart';
import '../../newTask/view.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 1;
  List<Widget> screens = [  const DoneTask(),const NewTask(),  const ArchivedTask()];
void changeIndex(int index){
  currentIndex =index ;
  emit(AppChangeBottomNavigationState());
}
  Database? database;
  List<Map>newTasks=[];
  List<Map>doneTasks=[];
  List<Map>archiveTasks=[];
  void createDatabase()  {
     openDatabase('todoApp.db', version: 1,
        onCreate: (database, version) {
          print('database created');
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT ,data TEXT ,date TEXT,status TEXT)')
              .then((value) {
            print("table created");
          }).catchError((error) {
            print("error when creating table ${error.toString()}");
          });
        }, onOpen: (database) {
          getDataFromDataBase(database);
          print('database opened');
        }).then((value) {
          database = value;
       emit(AppCreateDataBase());
     });
  }

   insertToDatabase({
    @required String? title,
    @required String? time,
    @required String? date,
  }) async {
     await database?.transaction((txn) => txn
        .rawInsert(
        'INSERT INTO tasks(title,data,date,status) VALUES("$title","$time","$date","new")')
        .then((value) {
      print("$value inserted successfully");
      print(newTasks);
      print(doneTasks);
      print(archiveTasks);
      emit(AppInsertDataBase());
      getDataFromDataBase(database);
    }).catchError((error) {
      print("error when creating table ${error.toString()}");
    }));
  }

  void getDataFromDataBase(database)  {
    newTasks =[];
    doneTasks=[];
    archiveTasks=[];
    emit(AppGetDataBaseLoading());
    database!.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element){
        final status = element['status'];// as String?;
        if (status == 'new') {
          newTasks.add(element);
        } else if (status =='done')
          doneTasks.add(element);
          else archiveTasks.add(element);
      });
      emit(AppGetDataBase());
    });

  }
  void updateData({
    @required String? status,
    @required int? id,
  }) async {

    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBase());

    });
  }
  void deleteData({

    @required int? id,
  }) async {

    database!.rawUpdate(
      'DELETE FROM tasks WHERE id = ?',
      [ id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBase());

    });
  }
  bool isBottomSheetShown = false;
  IconData? floatingIcon = Icons.edit;
  void changeBottomSheetState({    required bool isShow,
    required IconData icon,}){
    isBottomSheetShown =isShow;
    floatingIcon =icon;
emit(AppChangeBottomSheetState());
  }
}