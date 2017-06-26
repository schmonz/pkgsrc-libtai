# $NetBSD: Makefile,v 1.12 2017/06/26 00:45:54 schmonz Exp $
#

DISTNAME=		libtai-0.60
PKGREVISION=		5
CATEGORIES=		devel
MASTER_SITES=		http://cr.yp.to/libtai/

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		http://cr.yp.to/libtai.html
COMMENT=		Library for storing and manipulating dates and times
LICENSE=		djb-nonlicense

CONFLICTS=		libowfat-[0-9]*

DJB_RESTRICTED=		NO

USE_TOOLS+=		nroff

EGDIR=			share/examples/${PKGBASE}
CONF_FILES+=		${EGDIR}/leapsecs.dat ${PKG_SYSCONFDIR}/leapsecs.dat

SUBST_FILES.djbware+=	leapsecs_read.c

INSTALLATION_DIRS=	bin include lib ${EGDIR}
INSTALLATION_DIRS+=	${PKGMANDIR}/man3

do-install:
	set -e; cd ${WRKSRC};						\
	for f in *.3; do						\
		${INSTALL_MAN} "$${f}" ${DESTDIR}${PREFIX}/${PKGMANDIR}/man3; \
	done;								\
	for f in easter nowutc leapsecs yearcal; do			\
		${INSTALL_PROGRAM} "$${f}" ${DESTDIR}${PREFIX}/bin;	\
	done;								\
	for f in *.h; do						\
		${INSTALL_DATA} "$${f}" ${DESTDIR}${PREFIX}/include;	\
	done;								\
	for f in libtai.a; do						\
		${INSTALL_LIB} "$${f}" ${DESTDIR}${PREFIX}/lib;		\
	done;								\
	for f in leapsecs.dat leapsecs.txt; do				\
		${INSTALL_DATA} "$${f}" ${DESTDIR}${PREFIX}/${EGDIR};	\
	done

.include "../../mk/djbware.mk"
.include "../../mk/bsd.pkg.mk"
