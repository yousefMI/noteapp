import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/shared/cubit/cubit.dart';

class NewTaskItem extends StatelessWidget {
  NewTaskItem(
      {super.key,
      required this.id,
      required this.date,
      this.isdone = false,
      this.isarchive = false,
      required this.time,
      required this.title});

  String date, time, title;
  int id;
  bool isarchive = false, isdone;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: id);
      },
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              border: const BorderDirectional(
                  end: BorderSide(width: 1, color: Colors.black38),
                  start: BorderSide(width: 1, color: Colors.black38),
                  top: BorderSide(width: 1, color: Colors.black38),
                  bottom: BorderSide(width: 1, color: Colors.black38))),
          child: ListTile(
            subtitle: Text(date, textAlign: TextAlign.center),
            trailing: SizedBox(
              width: 100.w,
              child: isarchive
                  ? IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .updateData(status: 'done', id: id);
                      },
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ))
                  : isdone
                      ? IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .updateData(status: 'archive', id: id);
                          },
                          icon: const Icon(
                            Icons.archive_outlined,
                            color: Colors.black,
                          ))
                      : Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .updateData(status: 'done', id: id);
                                },
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .updateData(status: 'archive', id: id);
                                },
                                icon: const Icon(
                                  Icons.archive_outlined,
                                  color: Colors.black,
                                )),
                          ],
                        ),
            ),
            leading: CircleAvatar(
              radius: 30.r,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
                child: Text(
                  textAlign: TextAlign.center,
                  "$time ",
                ),
              ), // Your image asset
            ),
            title: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
              ),
            ), // Your title
          ),
        ),
      ),
    );
  }
}