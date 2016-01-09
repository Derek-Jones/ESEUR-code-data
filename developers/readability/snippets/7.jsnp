  /**
   * Attention: DO NOT USE THIS!
   * Under Os/2 it has some problems with calculating the real Date!
   * 
   * @deprecated
   */
  public Date(int daysSince1970) {

    long l = (long) daysSince1970 * 24 * 60 * 60 * 1000;
    java.util.Date d = new java.util.Date(l);
    Calendar cal = Calendar.getInstance();
