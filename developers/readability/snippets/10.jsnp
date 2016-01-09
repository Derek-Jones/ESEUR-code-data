    private void moveUnit(KeyEvent e) {
        if (!parent.isMapboardActionsEnabled()) {
            return;
        }
        
        switch (e.getKeyCode()) {
        case KeyEvent.VK_ESCAPE:
            // main menu
            break;
        case KeyEvent.VK_NUMPAD1:
        case KeyEvent.VK_END:
            inGameController.moveActiveUnit(Map.SW);
