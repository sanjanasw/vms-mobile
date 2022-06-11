import 'package:flutter/material.dart';

class PreVaccineCheckList extends StatefulWidget {
  static String routeName = '/PreVaccineCheckListScreen';

  @override
  State<PreVaccineCheckList> createState() => _PreVaccineCheckListState();
}

class _PreVaccineCheckListState extends State<PreVaccineCheckList> {
  List<CheckListItem> _checkListItems = <CheckListItem>[
    CheckListItem(
      header: "Are you feeling sick?",
      body:
          "While there is no evidence acute illness reduces vaccine efficacy or increases adverse reactions, as a precaution, "
          "delay vaccinating patients with moderate or severe illness until the illness has improved."
          "Defer vaccination of people with current SARS-CoV-2 infection until the person has recovered from acute "
          "illness and has discontinued isolation. "
          "This recommendation applies regardless of whether the SARS-CoV-2 infection occurred before the recipient "
          "received an initial dose or between doses. Viral or serological testing to assess for current or prior "
          "infection solely for the purpose of vaccine-decision making is not recommended."
          " People with mild illnesses can be vaccinated. Do not withhold vaccination if a person is taking antibiotics.",
      isExpanded: false,
    ),
    CheckListItem(
      header: "Have you ever received a dose of COVID-19 vaccine?",
      body:
          " People 5 years of age and older should receive a primary series of COVID-19 vaccine. All COVID-19 primary series doses and additional primary doses should be the same vaccine product. Booster doses, for eligible persons, may be a different product than the COVID-19 vaccine product used in the primary series (e.g., mix and match may be used for boosters). ",
      isExpanded: false,
    ),
    CheckListItem(
      header:
          "Do you have a health condition or are you undergoing treatment that makes you moderately or severely immunocompromised?",
      body:
          "This would include treatment for cancer or HIV, receipt of organ transplant, immunosuppressive therapy or high-dose corticosteroids, CAR-T-cell therapy, hematopoietic cell transplant [HCT], DiGeorge syndrome or Wiskott-Aldrich syndrome. \n COVID-19 vaccines may be administered to people with underlying medical conditions, such as HIV infection or other immunocompromising conditions, or who take immunosuppressive medications or therapies, who have no contraindications to vaccination. \n Moderately or severely immunocompromised persons 12 years of age and older (Pfizer-BioNTech recipients) or 18 years and older (Moderna recipients) should receive an additional primary dose of the same mRNA COVID-19 vaccine administered for the  ",
      isExpanded: false,
    ),
    CheckListItem(
      header:
          "Have you received hematopoietic cell transplant (HCT) or CAR-T-cell therapies since receiving COVID-19 vaccine?",
      body:
          "HCT and CAR-T-cell recipients who received doses of COVID-19 vaccine prior to receiving an HCT or CAR-T-cell therapy should be revaccinated with a primary vaccine series at least 3 months (12 weeks) after transplant or CAR-T-cell therapy.",
      isExpanded: false,
    ),
    CheckListItem(
      header: "Have you ever had an allergic reactions?",
      body:
          " This would include a severe allergic reaction [e.g., anaphylaxis] that required treatment with epinephrine or EpiPen® or that caused you to go to the hospital. It would also include an allergic reaction that caused hives, swelling, or respiratory distress, including wheezing. \n  A component of a COVID-19 vaccine, including either of the following: \n Polyethylene glycol (PEG), which is found in some medications, such as laxatives and preparations for colonoscopy procedures. \n Polysorbate, which is found in some vaccines, film coated tablets, and intravenous steroids.",
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pre-Vaccine Self-Check List"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 20),
            child: ExpansionPanelList(
              elevation: 4,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _checkListItems[index].isExpanded =
                      !_checkListItems[index].isExpanded;
                });
              },
              children: _checkListItems.map((item) {
                return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          item.header,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    isExpanded: item.isExpanded,
                    body: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        child: Text(
                          item.body,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class CheckListItem {
  CheckListItem({this.isExpanded: false, this.header, this.body});
  bool isExpanded;
  final String header;
  final String body;
}
