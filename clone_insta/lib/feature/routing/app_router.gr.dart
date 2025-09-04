// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:clone_insta/product/sign/sign_in/sign_in_view.dart' as _i1;
import 'package:clone_insta/product/sign/sign_shell_view.dart' as _i2;
import 'package:clone_insta/product/sign/sign_up/sign_up_view.dart' as _i3;

/// generated route for
/// [_i1.SignInView]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute({List<_i4.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.SignInView();
    },
  );
}

/// generated route for
/// [_i2.SignShellView]
class SignShellRoute extends _i4.PageRouteInfo<void> {
  const SignShellRoute({List<_i4.PageRouteInfo>? children})
    : super(SignShellRoute.name, initialChildren: children);

  static const String name = 'SignShellRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignShellView();
    },
  );
}

/// generated route for
/// [_i3.SignUpView]
class SignUpRoute extends _i4.PageRouteInfo<void> {
  const SignUpRoute({List<_i4.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignUpView();
    },
  );
}
