import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class FloatingSearchBar extends StatelessWidget {
  FloatingSearchBar({
    this.body,
    this.drawer,
    this.trailing,
    this.leading,
    this.endDrawer,
    this.controller,
    this.onChanged,
    this.title,
    this.decoration,
    this.onTap,
    @required List<Widget> children,
  }) : _childDelagate = SliverChildListDelegate(
          children,
        );

  FloatingSearchBar.builder({
    this.body,
    this.drawer,
    this.endDrawer,
    this.trailing,
    this.leading,
    this.controller,
    this.onChanged,
    this.title,
    this.onTap,
    this.decoration,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
  }) : _childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final Widget leading, trailing, body, drawer, endDrawer;

  final SliverChildDelegate _childDelagate;

  final TextEditingController controller;

  final ValueChanged<String> onChanged;

  final InputDecoration decoration;

  final VoidCallback onTap;

  /// Override the search field
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      endDrawer: endDrawer,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFloatingBar(
            leading: leading,
            floating: true,
            title: title ??
                TextField(
                  controller: controller,
                  decoration: decoration ??
                      InputDecoration.collapsed(
                        hintText: "Search...",
                      ),
                  autofocus: false,
                  onChanged: onChanged,
                  onTap: onTap,
                ),
            trailing: trailing,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(12.5)),
                    height: 50.0,
                  ),
                ),
              )
            ]),
          ),
          SliverList(
            delegate: _childDelagate,
          ),
        ],
      ),
    );
  }
}
