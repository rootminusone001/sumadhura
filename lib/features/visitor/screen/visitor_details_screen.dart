import 'package:flutter/material.dart';
import 'package:sumadhura/features/qr_code_generator/screen/qr_code_generator.dart';
import 'package:sumadhura/features/visitor/visitor_bloc/details_row_widget.dart';
import 'package:sumadhura/features/visitor/widgets/details_card.dart';
import 'package:sumadhura/features/visitor/widgets/portfolio_card.dart';
import 'package:sumadhura/features/visitor/widgets/section_title_widget.dart';
import 'package:sumadhura/model/visitors_model.dart';
import 'package:sumadhura/utils/time_stamp_formats.dart';

class VisitorDetailsScreen extends StatelessWidget {
  final Visitors visitor;

  const VisitorDetailsScreen({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitleWidget(title: 'Visitor QR Code'),
            Container(
              alignment: Alignment.bottomCenter,
              child: VisitorQrCode(visitorId: visitor.id),
            ),
            const SizedBox(height: 20),
            // Visitor profile card
            PortfolioCard(visitor: visitor),

            const SizedBox(height: 20),

            SectionTitleWidget(title: 'Contact Information'),

            DetailsCard(
              cardChildren: [
                DetailsRowWidget(
                  icon: Icons.phone_outlined,
                  label: 'Mobile Number',
                  value: visitor.mobile,
                ),
                DetailsRowWidget(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: visitor.email ?? 'Not provided',
                ),
              ],
            ),

            const SizedBox(height: 20),

            SectionTitleWidget(title: 'Visit Information'),

            DetailsCard(
              cardChildren: [
                DetailsRowWidget(
                  icon: Icons.badge_outlined,
                  label: 'Visitor Type',
                  value: visitor.visitorType,
                ),
                DetailsRowWidget(
                  icon: Icons.business_outlined,
                  label: 'Project',
                  value: visitor.project,
                ),
                DetailsRowWidget(
                  icon: Icons.description_outlined,
                  label: 'Purpose',
                  value: visitor.purpose,
                ),
              ],
            ),

            const SizedBox(height: 20),

            SectionTitleWidget(title: 'Visit Timeline'),

            DetailsCard(
              cardChildren: [
                DetailsRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: 'Registered At',
                  value: TimeStampFormats.formatDate(visitor.createdAt),
                ),
                DetailsRowWidget(
                  icon: Icons.login_outlined,
                  label: 'Check-in Time',
                  value: TimeStampFormats.formatDate(visitor.checkInTime),
                ),
                DetailsRowWidget(
                  icon: Icons.logout_outlined,
                  label: 'Check-out Time',
                  value: TimeStampFormats.formatDate(visitor.checkOutTime),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
