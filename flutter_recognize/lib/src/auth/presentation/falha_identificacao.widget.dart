import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FalhaIdentificacao extends StatelessWidget {
  Future Function() onClickViaMatricula;
  FalhaIdentificacao({
    @required this.onClickViaMatricula,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;

    return Container(
      width: w * 100,
      child: Center(
        child: Container(
          width: w * 88,
          height: h * 26.5,
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: h * 4,
                child: Center(
                  child: Container(
                    width: w * 88,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Falha na identificação",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: h * 1),
                        const Text(
                          "Não foi possível identificar o rosto.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: h * 3.5,
                child: Container(
                  width: w * 88,
                  padding: EdgeInsets.only(left: w * 16, right: w * 16),
                  child: Center(
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 4.5, bottom: 4.5),
                      onPressed: onClickViaMatricula,
                      color: Colors.white,
                      child: Text(
                        "Bater ponto sem identificação facial",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red[400],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
