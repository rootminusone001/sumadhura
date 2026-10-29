import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumadhura/features/register_visitor/register_visitor_bloc/register_visitor_bloc.dart';
import 'package:sumadhura/features/register_visitor/screen/register_visitor_screen.dart';
import 'package:sumadhura/features/visitor/visitor_bloc/visitor_bloc.dart';
import 'package:sumadhura/features/visitor/widgets/visitor_card.dart';
import 'package:sumadhura/features/visitor/screen/visitor_details_screen.dart';
import 'package:sumadhura/widget/delete_alert_dialog.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitorBloc>().add(GetVisitorsEvent());
    });
  }

  @override
  dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VisitorBloc>().add(GetVisitorsEvent());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Visitors')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search Visitors',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  context.read<VisitorBloc>().add(
                    SearchVisitorsEvent(query: query),
                  );
                },
              ),
            ),
            Expanded(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<RegisterVisitorBloc, RegisterVisitorState>(
                    listener: (context, state) {
                      if (state is EditVisitorSuccessState ||
                          state is RegisterVisitorSuccessState) {
                        context.read<VisitorBloc>().add(GetVisitorsEvent());
                      }
                    },
                  ),
                  BlocListener<VisitorBloc, VisitorState>(
                    listener: (context, state) {
                      if (state is DeleteVisitorSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Visitor deleted successfully'),
                          ),
                        );
                        context.read<VisitorBloc>().add(GetVisitorsEvent());
                      } else if (state is DeleteVisitorFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Failed to delete visitor: //${state.errorMessage}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
                child: BlocBuilder<VisitorBloc, VisitorState>(
                  builder: (context, state) {
                    if (state is VisitorLoadingState ||
                        state is VisitorInitialState) {
                      return CircularProgressIndicator();
                    } else if (state is VisitorSuccessState) {
                      final visitors = state.visitors;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: visitors.length,
                        itemBuilder: (context, index) {
                          final visitor = visitors[index];
                          return VisitorCard(
                            visitor: visitor,
                            onDelete: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return DeleteAlertDialog(
                                    dialogContext: dialogContext,
                                    visitorName: visitor.name,
                                    onDelete: () {
                                      context.read<VisitorBloc>().add(
                                        DeleteVisitorsEvent(
                                          visitorId: visitor.id,
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterVisitorScreen(
                                    visitorId: visitor.id,
                                    isEditMode: true,
                                  ),
                                ),
                              );
                            },
                            onTap: () {
                              showDialog(
                                context: context,

                                builder: (dialogContext) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 24,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    content: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.9,
                                      child: VisitorDetailsScreen(
                                        visitor: visitor,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                    return Text('No Visitors');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
