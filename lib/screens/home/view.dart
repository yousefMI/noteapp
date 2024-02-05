import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/shared/cubit/cubit.dart';
import 'package:noteapp/shared/cubit/states.dart';
import 'package:noteapp/shared/my_text_form.dart';

class HomeScreen extends StatelessWidget
{

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDataBase){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(resizeToAvoidBottomInset: true,
            key: scaffoldKey,
            //appBar: AppBar(),
            body: ConditionalBuilder(
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: ( context) => const Center(child: CircularProgressIndicator()),
                condition:state is! AppGetDataBaseLoading,//tasks.length > 0,
            ),
            floatingActionButton: FloatingActionButton(tooltip: "add new task",
              shape: const CircleBorder(),
              onPressed: () {
                if (cubit.isBottomSheetShown ) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                  }
                } else { showModalBottomSheet( isDismissible: false,enableDrag: false,
                  context:context,builder:(context)=>  Stack(alignment: AlignmentDirectional.topEnd,
                    children: [
                      Padding(
                            padding:  EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom,),
                        child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Padding(
                              padding: EdgeInsets.all(20.0.w),
                                 child: SizedBox(
                                 width: double.infinity,
                               // height: 255.h,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MyTextFormField(
                                        prefix: Icons.title_outlined,
                                        hintText: "enter your title",
                                        controller: titleController,
                                        label: "Title",
                                        type: TextInputType.text,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      MyTextFormField(
                                        prefix: Icons.watch_later_outlined,
                                        onTapFunction: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text =
                                                value!.format(context);
                                          });
                                        },
                                        hintText: "enter your time",
                                        controller: timeController,
                                        label: "time",
                                        type: TextInputType.none,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      MyTextFormField(
                                        prefix: Icons.date_range_outlined,
                                        onTapFunction: () {
                                          showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate:
                                            DateTime.parse("2025-12-31"),
                                            initialDate: DateTime.now(),
                                          ).then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        hintText: "enter your time",
                                        controller: dateController,
                                        label: "date",
                                        type: TextInputType.none,
                                      ),
                                    ]),
                              ),
                                                  ),
                                                ),
                            ),
                          ),
                      Transform.translate(//top: -25.h ,
                       // right: 16.0.w,q
                        offset: Offset(-16.w, -25.h),
                        child: FloatingActionButton(child: Icon(cubit.floatingIcon),shape: const CircleBorder(),onPressed: (){
                          if (formKey.currentState!.validate()) {
                            cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                            cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                            titleController.clear();
                            timeController.clear();
                            dateController.clear();
                          }//else cubit.changeBottomSheetState (isShow:true , icon: Icons.favorite_border);


                          // cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                          // cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                          // titleController.clear();
                          // timeController.clear();
                          // dateController.clear();
                         // Navigator.pop(context);
                        }),
                      )
                    ],
                  )) ;
                    //   .closed
                    //   .then((value) {
                    // cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                    // // setState(() {
                    //   floatingIcon = Icons.edit;
                    //   titleController.clear();
                    //   timeController.clear();
                    //   dateController.clear();
                    // });
                 // });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  //isBottomSheetShown = true;
                  // setState(() {
                  //   floatingIcon = Icons.add;
                  // });
                }
              },
              child: Icon(cubit.floatingIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.format_list_bulleted), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done), label: "Tasks"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: "Archive",
                  ),
                ]),
          );
        },
      ),
    );
  }


}

