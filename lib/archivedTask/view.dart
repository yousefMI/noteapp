import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/newTask/newTaskItem.dart';
import 'package:noteapp/shared/cubit/cubit.dart';
import 'package:noteapp/shared/cubit/states.dart';

class ArchivedTask extends StatelessWidget {
  const ArchivedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = AppCubit.get(context).archiveTasks;
          return ListView.builder(physics: BouncingScrollPhysics(),
            itemCount: list.length,
           // padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 5.w),
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.0.w,vertical: 5.h),
                child: NewTaskItem(isarchive: true,
                    date: "${list[index]['date']}",
                    id: list[index]['id'],
                    time: "${list[index]['data']}",
                    title: "${list[index]['title']}"),
              );
            },
          );
        },
      ),
    );
  }
}