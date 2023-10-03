import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';
import 'package:lya_encuestas/widgets/pickers/channel_picker/channel_picker.dart';
import 'package:lya_encuestas/widgets/pickers/channel_picker/channel_picker_provider.dart';
import 'package:provider/provider.dart';

class ChannelPickerBuilder {
  static Widget build(context, Channel? selChannel, setState) {
    Channel? returnChannel;
    Future<void> onTap() async {
      final provider =
          Provider.of<ChannelPickerProvider>(context, listen: false);
      provider.reloadChannels();
      returnChannel = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChannelPicker()));
      if (returnChannel == null) return;
      setState(returnChannel);
    }

    return ChannelPickerBuilder.buildChannelPicker(
      child: selChannel == null
          ? ChannelPickerBuilder.buildListTile(
              title: 'Seleccione', onTap: onTap)
          : ChannelPickerBuilder.buildListTile(
              title: selChannel.name,
              onTap: onTap,
            ),
    );
  }

  static Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  static Widget buildChannelPicker({
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
