


import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class BottomNavigationItem extends StatefulWidget {
  final String  mode;
  final String  type;

  final Function  fnPage;
  final Function  fnSave;
  final Function  fnEdit;
  final Function  fnAdd;
  final Function  fnCancel;
  final Function  fnDelete;
   BottomNavigationItem({Key? key, required this.mode,this.type="",  required this.fnPage, required this.fnSave, required this.fnEdit, required this.fnAdd, required this.fnCancel,  required this.fnDelete,}) : super(key: key);

  @override
  _BottomNavigationItemState createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {

  var mode = '';
  var selectedItemV = 0;
  var selectedItemA = 0;
  var selectedItemE = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fnMode() == 'VIEW'  ?
    BottomNavigationBar(
      items:    <BottomNavigationBarItem>[

        const BottomNavigationBarItem(
            icon: Icon(
              Icons.first_page_rounded,
              color:primaryColor,),
            label:'First',
            backgroundColor: Colors.white),
        const BottomNavigationBarItem(
            icon: Icon(Icons.skip_previous,
              color: primaryColor,),
            label:'Previous',
            backgroundColor: Colors.white),
        const BottomNavigationBarItem(
            icon: Icon(Icons.skip_next,
              color: primaryColor,),
            label:'Next',
            backgroundColor: Colors.white),
        const BottomNavigationBarItem(
            icon: Icon(Icons.last_page,
              color: primaryColor,),
            label:'Last',
            backgroundColor: Colors.white),
        const BottomNavigationBarItem(
            icon: Icon(Icons.add_box,
              color: primaryColor,),
            label:'Add',
            backgroundColor: Colors.white),
        const BottomNavigationBarItem(
            icon: Icon(Icons.edit,
              color: primaryColor,),
            label:'Edit',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever,
              color: widget.type=="booking"?Colors.grey:primaryColor,),
            label:'Delete',
            backgroundColor: Colors.white)

      ],

      type: BottomNavigationBarType.shifting,
      currentIndex: selectedItemV,
      selectedItemColor: primaryColor,
      iconSize: 20,
      onTap: (index){
        setState(() {
          selectedItemV = index;
          fnButtonClick(index);
        });
      },
      elevation: 3,
    ) :
    BottomNavigationBar(
      items:  const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
            icon: Icon(Icons.save_sharp,
              color: primaryColor,),
            label:'Save',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.cancel,
              color: primaryColor,),
            label:'Cancel',
            backgroundColor: Colors.white),

      ],

      type: BottomNavigationBarType.shifting,
      currentIndex: selectedItemA,
      selectedItemColor: primaryColor,
      iconSize: 25,
      onTap: (index){
        setState(() {
          selectedItemA = index;
          fnButtonClick(index);
        });
      },
      elevation: 3,
    );
  }

  fnMode(){
    var m = '';
    m = widget.mode;
    return m;
  }

  fnButtonClick(index){
    if(widget.mode == 'VIEW'){
      switch (index) {
        case 0:
          widget.fnPage('FIRST');
          break;
        case 1:
          widget.fnPage('PREVIOUS');
          break;
        case 2:
          widget.fnPage('NEXT');
          break;
        case 3:
          widget.fnPage('LAST');
          break;
        case 4:
          widget.fnAdd();
          break;
        case 5:
          widget.fnEdit();
          break;
        case 6:
          widget.fnDelete();
          break;
        default:
          break;
      }
    }else{
      switch (index) {
        case 0:
          widget.fnSave();
          break;
        case 1:
         widget.fnCancel();
          break;
      }
    }
  }


}

