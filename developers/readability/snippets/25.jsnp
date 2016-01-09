
            public boolean check(Unit u, PathNode p) {
                if (p.getTile().getSettlement() != null && p.getTile().getSettlement().getOwner() == player
                        && p.getTile().getSettlement() != inSettlement) {
                    Settlement s = p.getTile().getSettlement();
                    int turns = p.getTurns();
                    destinations.add(new ChoiceItem(s.toString() + " (" + turns + ")", s));
