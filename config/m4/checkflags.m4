dnl Check if compiler accepts FLAG in CXXFLAGS. If accepted, do
dnl ACTION-IF-FLAG-WORKS. Otherwise do ACTION-IF-FLAG-DOES-NOT-WORK.
dnl
dnl SP_CHECK_CXXFLAG(FLAG, [ACTION-IF-FLAG-WORKS], [ACTION-IF-FLAG-DOES-NOT-WORK])

AC_DEFUN([SP_CHECK_CXXFLAG], [
	AC_CACHE_CHECK([whether $CXX supports $1 in CXXFLAGS],
		[AS_TR_SH([sockperf_cv_cxxflags_$1])], [
		saved_cxxflags="$CXXFLAGS"
		CXXFLAGS="$1"
		AC_LINK_IFELSE([AC_LANG_PROGRAM()],
			[eval "AS_TR_SH([sockperf_cv_cxxflags_$1])='yes'"],
			[eval "AS_TR_SH([sockperf_cv_cxxflags_$1])='no'"])
		CXXFLAGS="$saved_cxxflags"])
	AS_IF([eval "test $"AS_TR_SH([sockperf_cv_cxxflags_$1])" = yes"],
		[$2], [$3])
])

dnl Check if compiler accepts FLAG in CXXFLAGS. If accepted, append the flag
dnl to environment variable ENV-VAR. Otherwise do ACTION-IF-FLAG-DOES-NOT-WORK.
dnl
dnl SP_CHECK_CXXFLAG_APPEND(ENV-VAR, FLAG, [ACTION-IF-FLAG-DOES-NOT-WORK])

AC_DEFUN([SP_CHECK_CXXFLAG_APPEND],
	 [SP_CHECK_CXXFLAG([$2], [$1="${$1} $2"], [$3])
])

dnl Check if compiler accepts FLAGS in CXXFLAGS. Append accepted flags to
dnl environment variable ENV-VAR. Ignore rejected flags.
dnl
dnl SP_CHECK_CXXFLAGS_APPEND(ENV-VAR, FLAGS)

AC_DEFUN([SP_CHECK_CXXFLAGS_APPEND], [
	for flag in $2; do
		SP_CHECK_CXXFLAG_APPEND([$1], [$flag])
	done])
