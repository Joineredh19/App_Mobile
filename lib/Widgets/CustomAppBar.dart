import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.leading,
    this.titleWidget,
    this.showActionIcon = false,
    this.onMenuActionTap,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

 @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Altura preferida de la AppBar
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2.5 ), 
        child: Stack(
          children: [
            Positioned.fill(
            
            child: titleWidget == null ?
            Center (child: Text(title, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white, )))
          : Center(
            child:  titleWidget !,
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                Transform.translate(
                  offset: const Offset(-14, 0),
                ),

              if (showActionIcon)
                Transform.translate(
                  offset: const Offset(10,0),
                  child: InkWell(
                      onTap: onMenuActionTap,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                         child: Icon(Icons.menu, color: Colors.white,),
                        ),
                  )
                )
            ],
          )
          ],
        ),
      ),
    );
  }
}
