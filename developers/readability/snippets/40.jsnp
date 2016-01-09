    /**
     * Handles an "deliverGift"-request.
     * 
     * @param element The element (root element in a DOM-parsed XML tree) that
     *            holds all the information.
     */
    private Element deliverGift(Element element) {
        Element unitElement = Message.getChildElement(element, Unit.getXMLElementTagName());

        Unit unit = (Unit) getGame().getFreeColGameObject(unitElement.getAttribute("ID"));
        unit.readFromXMLElement(unitElement);
