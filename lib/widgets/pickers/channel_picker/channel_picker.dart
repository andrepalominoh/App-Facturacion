import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';
import 'package:lya_encuestas/widgets/search_data.dart';
import 'package:lya_encuestas/widgets/pickers/channel_picker/channel_picker_item.dart';
import 'package:lya_encuestas/widgets/pickers/channel_picker/channel_picker_provider.dart';
import 'package:provider/provider.dart';

class ChannelPicker extends StatefulWidget {
  final bool isMultiSelection;
  final List<Channel> channels;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ChannelPicker({
    this.isMultiSelection = false,
    this.channels = const [],
  });

  @override
  _ChannelPickerState createState() {
    return _ChannelPickerState();
  }
}

class _ChannelPickerState extends State<ChannelPicker> {
  String text = '';
  List<Channel> selectedChannels = [];

  @override
  void initState() {
    super.initState();

    selectedChannels = widget.channels;
  }

  static int ascendingSort(Channel c1, Channel c2) =>
      c1.name.compareTo(c2.name);

  bool containsSearchText(Channel channel) {
    final name = channel.name;
    final textLower = text.toLowerCase();
    final channelLower = name.toLowerCase();

    return channelLower.contains(textLower);
  }

  List<Channel> getPrioritizedChannels(List<Channel> channels) {
    final notSelectedChannels = List.of(channels)
      ..removeWhere((channel) => selectedChannels.contains(channel));

    return [
      ...List.of(selectedChannels)..sort(ascendingSort),
      ...notSelectedChannels,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChannelPickerProvider>(context);
    final allChannels = getPrioritizedChannels(provider.channels);
    final channels = allChannels.where(containsSearchText).toList();
    final label = widget.isMultiSelection ? 'Canales' : 'Canal';

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar $label'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SearchData(
            text: text,
            onChanged: (text) => setState(() => this.text = text),
            hintText: 'Buscar $label',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: channels.map((channel) {
                final isSelected = selectedChannels.contains(channel);
                return ChannelPickerItem(
                  channel: channel,
                  isSelected: isSelected,
                  onSelectedChannel: selectChannel,
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  Widget buildSelectButton(BuildContext context) {
    final label = widget.isMultiSelection
        ? 'Seleccionar ${selectedChannels.length} Canales'
        : 'Continuar';

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Constants.COLOR_PRIMARY, // <-- Red color provided to below Row
        child: Column(children: [
          CustomButton(onPressed: submit, title: label),
        ]));
  }

  void selectChannel(Channel channel) {
    if (widget.isMultiSelection) {
      final isSelected = selectedChannels.contains(channel);
      setState(() => isSelected
          ? selectedChannels.remove(channel)
          : selectedChannels.add(channel));
    } else {
      Navigator.pop(context, channel);
    }
  }

  void submit() {
    if (widget.isMultiSelection) {
      Navigator.pop(context, selectedChannels);
    } else {
      Navigator.pop(context, null);
    }
  }
}
