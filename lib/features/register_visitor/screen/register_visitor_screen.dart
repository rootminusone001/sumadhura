import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumadhura/constants/visitor_essential_choices.dart';
import 'package:sumadhura/features/register_visitor/register_visitor_bloc/register_visitor_bloc.dart';
import 'package:sumadhura/model/visitors_model.dart';
import 'package:sumadhura/utils/project_enums.dart';
import 'package:sumadhura/widget/generic_dropdown_widget.dart';
import 'package:sumadhura/widget/generic_text_form_field_widget.dart';
import 'package:sumadhura/widget/time_info_card.dart';

class RegisterVisitorScreen extends StatefulWidget {
  final bool isEditMode;
  final int? visitorId;
  const RegisterVisitorScreen({
    super.key,
    this.isEditMode = false,
    this.visitorId,
  });

  @override
  State<RegisterVisitorScreen> createState() => _RegisterVisitorScreenState();
}

class _RegisterVisitorScreenState extends State<RegisterVisitorScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  String? selectedVisitorType;
  String? selectedProject;

  String createdAt = '';
  String checkInTime = '';
  String checkOutTime = '';

  VisitorStatus? visitorStatus;

  List<DropdownMenuItem<VisitorStatus>> visitorStatusItems() {
    return VisitorEssentialChoices.visitorStatus.entries.map((entry) {
      final status = entry.key;
      final label = entry.value;

      final bool isDisabled;

      switch (visitorStatus) {
        case VisitorStatus.REGISTERED:
          // Can remain Registered or move to Checked In.
          isDisabled = status == VisitorStatus.CHECKEDOUT;
          break;

        case VisitorStatus.CHECKEDIN:
          // Can remain Checked In or move to Checked Out.
          isDisabled = status == VisitorStatus.REGISTERED;
          break;

        case VisitorStatus.CHECKEDOUT:
          // Cannot move backward from Checked Out.
          isDisabled = status != VisitorStatus.CHECKEDOUT;
          break;

        default:
          isDisabled = true;
      }

      return DropdownMenuItem<VisitorStatus>(
        value: status,
        enabled: !isDisabled,
        child: Text(
          label,
          style: TextStyle(color: isDisabled ? Colors.grey : null),
        ),
      );
    }).toList();
  }

  @override
  initState() {
    super.initState();
    if (!widget.isEditMode) {
      selectedVisitorType = VisitorEssentialChoices.visitorType.isNotEmpty
          ? VisitorEssentialChoices.visitorType.first
          : null;
      selectedProject = VisitorEssentialChoices.project.isNotEmpty
          ? VisitorEssentialChoices.project.first
          : null;
      visitorStatus = VisitorStatus.REGISTERED;
    }
    if (widget.isEditMode && widget.visitorId != null) {
      context.read<RegisterVisitorBloc>().add(
        FetchVisitorDetailsEvent(visitorId: widget.visitorId!),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterVisitorBloc, RegisterVisitorState>(
      listener: (context, state) {
        if (state is RegisterVisitorLoadingState ||
            state is EditVisitorLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegisterVisitorSuccessState && !widget.isEditMode) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is RegisterVisitorSuccessState && widget.isEditMode) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).pop();
          setState(() {
            nameController.text = state.visitor.name;
            mobileNumberController.text = state.visitor.mobile;
            emailController.text = state.visitor.email ?? '';
            purposeController.text = state.visitor.purpose;
            selectedVisitorType = state.visitor.visitorType;
            selectedProject = state.visitor.project;
            purposeController.text = state.visitor.purpose;
            visitorStatus = VisitorStatus.values.firstWhere(
              (status) =>
                  VisitorEssentialChoices.visitorStatus[status] ==
                  state.visitor.status,
              orElse: () => VisitorStatus.REGISTERED,
            );
            createdAt = state.visitor.createdAt ?? '';
            checkInTime = state.visitor.checkInTime ?? '';
            checkOutTime = state.visitor.checkOutTime ?? '';
          });
        } else if (state is RegisterVisitorFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is EditVisitorSuccessState) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is EditVisitorFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register Visitor')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                GenericTextFormFieldWidget(
                  textEditingController: nameController,
                  labelText: 'Name*',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                GenericTextFormFieldWidget(
                  textEditingController: mobileNumberController,
                  labelText: 'Mobile Number*',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value) &&
                        value.length != 10) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                GenericTextFormFieldWidget(
                  textEditingController: emailController,
                  labelText: 'Email',
                  validator: (String? value) {
                    if (!(value == null || value.isEmpty)) {
                      return value.codeUnits.contains(64)
                          ? null
                          : 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                GenericTextFormFieldWidget(
                  textEditingController: purposeController,
                  labelText: 'Purpose*',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purpose';
                    }
                    return null;
                  },
                ),
                GenericDropdownWidget(
                  initialValue: selectedVisitorType,
                  hintText: 'Select visitor type',
                  labelText: 'Visitor Type*',
                  items: VisitorEssentialChoices.visitorType.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select visitor type';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      selectedVisitorType = value;
                    });
                  },
                ),
                GenericDropdownWidget(
                  initialValue: selectedProject,
                  hintText: 'Select project type',
                  labelText: 'Project*',
                  items: VisitorEssentialChoices.project.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select project type';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      selectedProject = value;
                    });
                  },
                ),

                widget.isEditMode
                    ? DropdownButtonFormField<VisitorStatus>(
                        initialValue: visitorStatus,
                        decoration: const InputDecoration(
                          labelText: 'Visitor Status*',
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text('Select visitor status'),
                        items: visitorStatusItems(),
                        onChanged: (VisitorStatus? value) {
                          setState(() {
                            visitorStatus = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Please select visitor status';
                          }
                          return null;
                        },
                      )
                    : const SizedBox.shrink(),
                if (widget.isEditMode &&
                        checkInTime.isNotEmpty &&
                        visitorStatus == VisitorStatus.CHECKEDIN ||
                    visitorStatus == VisitorStatus.CHECKEDOUT) ...[
                  const SizedBox(height: 8),
                  TimeInfoCard(
                    icon: Icons.login,
                    label:
                        VisitorEssentialChoices.visitorStatus[VisitorStatus
                            .CHECKEDIN] ??
                        '',
                    value: checkInTime,
                  ),
                ],

                if (visitorStatus == VisitorStatus.CHECKEDOUT &&
                    checkOutTime.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  TimeInfoCard(
                    icon: Icons.logout,
                    label:
                        VisitorEssentialChoices.visitorStatus[VisitorStatus
                            .CHECKEDOUT] ??
                        '',
                    value: checkOutTime,
                  ),
                ],
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),

          child: ElevatedButton(
            onPressed: () {
              if (widget.isEditMode && _formKey.currentState!.validate()) {
                context.read<RegisterVisitorBloc>().add(
                  EditVisitorEvent(
                    visitor: Visitors(
                      id: widget.visitorId,
                      name: nameController.text,
                      mobile: mobileNumberController.text,
                      email: emailController.text.isNotEmpty
                          ? emailController.text
                          : null,
                      visitorType: selectedVisitorType ?? '',
                      project: selectedProject ?? '',
                      purpose: purposeController.text,
                      status: visitorStatus != null
                          ? VisitorEssentialChoices
                                    .visitorStatus[visitorStatus!] ??
                                'Registered'
                          : 'Registered',
                      createdAt: createdAt.isNotEmpty ? createdAt : null,
                      checkInTime: checkInTime.isNotEmpty ? checkInTime : null,
                      checkOutTime: checkOutTime.isNotEmpty
                          ? checkOutTime
                          : null,
                    ),
                  ),
                );
              }
              if (!widget.isEditMode && _formKey.currentState!.validate()) {
                context.read<RegisterVisitorBloc>().add(
                  RegisterVisitorEvent(
                    visitor: Visitors(
                      name: nameController.text,
                      mobile: mobileNumberController.text,
                      email: emailController.text.isNotEmpty
                          ? emailController.text
                          : null,
                      visitorType: selectedVisitorType ?? '',
                      project: selectedProject ?? '',
                      purpose:
                          purposeController.text, // Placeholder for purpose
                      status: visitorStatus != null
                          ? VisitorEssentialChoices
                                    .visitorStatus[visitorStatus!] ??
                                'Registered'
                          : 'Registered',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF345E8D),
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text(widget.isEditMode ? 'Update' : 'Submit'),
          ),
        ),
      ),
    );
  }
}
