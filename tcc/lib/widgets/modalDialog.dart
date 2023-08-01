import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context,
    {VoidCallback? onCameratap, VoidCallback? onGaleriaTap}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(230, 199, 151, 223),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          padding: EdgeInsets.all(24),
          height: 220,
          child: Column(
            children: [
              GestureDetector(
                onTap: onCameratap,
                child: Card(
                  color: Colors.transparent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 91, 28, 111),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: onGaleriaTap,
                child: Card(
                  color: Colors.transparent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 91, 28, 111),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Text(
                      "Galeria",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
