import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:bta3_physia_admin/features/live/presentation/cubit/live_cubit.dart';

class LiveFormArgs {
  const LiveFormArgs({required this.cubit, this.initialLive});

  final LiveCubit cubit;

  final LiveStreamModel? initialLive;
}
