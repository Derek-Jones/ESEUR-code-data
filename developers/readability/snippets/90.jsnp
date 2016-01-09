    public boolean displayTileCursor(Tile tile, int canvasX, int canvasY) {
        if (currentMode == ViewMode.VIEW_TERRAIN_MODE) {

            Position selectedTilePos = gui.getSelectedTile();
            if (selectedTilePos == null)
                return false;

            if (selectedTilePos.getX() == tile.getX() && selectedTilePos.getY() == tile.getY()) {
                TerrainCursor cursor = gui.getCursor();
