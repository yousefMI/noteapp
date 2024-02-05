import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/newTask/newTaskItem.dart';
import 'package:noteapp/shared/cubit/cubit.dart';
import 'package:noteapp/shared/cubit/states.dart';

class DoneTask extends StatelessWidget {
  const DoneTask({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).doneTasks;
          return ListView.builder(physics: BouncingScrollPhysics(),
            itemCount: tasks.length,
           // padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 5.w),
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.0.w,vertical: 5.h),
                child: NewTaskItem(isdone: true,
                    date: "${tasks[index]['date']}",
                    id: tasks[index]['id'],
                    time: "${tasks[index]['data']}",
                    title: "${tasks[index]['title']}"),
              );
            },
          );
        },
      ),
    );
  }
}
