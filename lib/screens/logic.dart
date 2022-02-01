import 'package:aara_task/api/api_service.dart';
import 'package:aara_task/screens/home_screen.dart';
import 'package:flutter/material.dart';

final phoneController = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Register')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/otp');
                },
                child: Text('OTP')),
          ],
        ),
      ),
    );
  }
}

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();
  //verifyotp
  callOtpApi() {
    final service = ApiServices();

    service.apiVerifyOtp(
      {
        "Mobile": phoneController.text,
        "OTP": otpController.text,
      },
    ).then((value) {
      if (value.msg != null) {
        print("get data >>>>>> " + value.msg!);
      } else {
        print(value.status!);
        print(value.data!);
        //push
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                initialValue: phoneController.text,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Otp",
                  labelText: "Enter Otp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: otpController,
              ),
              SizedBox(
                height: 50,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange.shade300,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    await callOtpApi();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Verify Otp",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  //login
  callLoginApi() {
    final service = ApiServices();

    service.apiLogin(
      {"Password": passwordController.text, "Username": phoneController.text},
    ).then((value) {
      if (value.msg != null) {
        print("get data >>>>>> " + value.msg!);
      } else {
        print(value.status!);
        print(value.data!);
        //push
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Mobile",
                  labelText: "Enter Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Password",
                  labelText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: GestureDetector(
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade300,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      onPressed: () async {
                        await callLoginApi();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 100),
              Material(
                elevation: 7,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegPage()));
                  },
                  child: const Text(
                    "New Register",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  final otpController = TextEditingController();

  //Reg Api
  callRegApi() {
    final service = ApiServices();

    service.apiReg(
      {
        "CustomerName": nameController.text,
        "CustomerPassword": passwordController.text,
        "CustomerPhone": phoneController.text,
        "CustomerEmail": emailController.text,
        "CustomerGender": genderController.text,
        "CustomerAddress": addressController.text,
      },
    ).then((value) {
      if (value.msg != null) {
        print("get data >>>>>> " + value.msg!);
      } else {
        print(value.status!);
        print(value.data!);
        //push
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Name",
                  labelText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Email",
                  labelText: "Enter your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Mobile",
                  labelText: "Enter your mobile",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Gender",
                  labelText: "Enter your gender",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                //obscureText: true,
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Address",
                  labelText: "Enter your address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    15,
                  ),
                  hintText: "Password",
                  labelText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange.shade300,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    await callRegApi();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => OtpPage()));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
