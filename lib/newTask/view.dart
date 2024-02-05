import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/newTask/newTaskItem.dart';
import 'package:noteapp/shared/cubit/cubit.dart';
import 'package:noteapp/shared/cubit/states.dart';

class NewTask extends StatelessWidget {
  const NewTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return Padding(
            padding:  EdgeInsetsDirectional.only(bottom: 10.0.h),
            child: ListView.builder(physics: BouncingScrollPhysics(),
              itemCount: tasks.length,
              //padding:EdgeInsetsDirectional.only(bottom: 10.h,start: 5.w),
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.0.w,vertical: 5.h),
                  child: NewTaskItem(
                      date: "${tasks[index]['date']}",
                      id: tasks[index]['id'],
                      time: "${tasks[index]['data']}",
                      title: "${tasks[index]['title']}"),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
