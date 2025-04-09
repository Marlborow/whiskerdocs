const puppeteer = require('puppeteer');
const path = require('path');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Get the absolute path of the file
  const filePath = path.resolve(process.argv[2]);
  const fileUrl = `file://${filePath}`;

  // Navigate to the file
  await page.goto(fileUrl, { waitUntil: 'networkidle0' });

  // Optional: Wait for MathJax to render
  await page.evaluate(() => MathJax.typesetPromise());

  // Export to PDF
  await page.pdf({
    path: process.argv[3],
    format: 'A4',
  });

  await browser.close();
})();

