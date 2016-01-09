
        for (int j = 0; j < fieldcount; j++) {
            int i = Column.compare(session.database.collation, a[cols[j]],
                                   b[cols[j]], coltypes[cols[j]]);

            if (i != 0) {
                return i;
            }
        }

        return 0;
