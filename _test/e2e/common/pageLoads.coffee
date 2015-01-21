exports.PageLoads = class PageLoads

  assertLoads: (page) =>
    browser.get(page)

    expect(element(By.id('footer')).isPresent()).
      toBe(true)
