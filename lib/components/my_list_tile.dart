import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyList({super.key,
  required this.title,
  required this.subtitle,

  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.only(left: 25.0,right: 25,
                      bottom: 25),
                      child: Container(
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                        child: ListTile(
                          
                          title: Text(title),
                          subtitle: Text(subtitle,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          ),
                        ),
                      ),
                    );
  }
}