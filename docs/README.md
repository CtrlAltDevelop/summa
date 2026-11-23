# Summa: مستندات بررسی مرجع (ترازنما، taraznama.com)

**Summa** اپ حسابداری شخصی (خرج، قسط، دارایی) برای مشتری خارجی است و از نظر هویت و شکل کاملاً متفاوت از ترازنما ساخته می‌شود. این مستندها بررسی ترازنما به‌عنوان مرجع ویژگی‌ها هستند و نباید عیناً کپی شوند.
تاریخ بررسی: ۱۴۰۵/۰۹/۰۱ (2026-11-22).

## تصمیم‌های ثبت‌شده
- استک: اپ Flutter، بک‌اند gRPC، و سایت لندینگ برای معرفی (مشابه ساختار پروژه taskforge، بدون لندینگ در آن). جزئیات در [AGENTS.md](../AGENTS.md).
- بک‌اند: Django + grpcio. فقط ایران و فارسی (ارزهای مختلف نگه داشته شد). ربات حذف؛ پیامک بانک خودکار. ظاهر و برند از فاز اول متفاوت.

## فهرست
1. [product-overview.md](01-product-overview.md): هویت محصول، پلتفرم‌ها، نقشه سایت، پلن‌ها و مدل درآمد
2. [features-flows.md](02-features-flows.md): فلوهای کاربری (ورود، ثبت خرج، پیامک بانک، قسط، دارایی، ربات، ابزارها، پشتیبانی)
3. [prices-data-sources.md](03-prices-data-sources.md): منابع قیمت و قوانین fallback
4. [security-privacy.md](04-security-privacy.md): امنیت، حریم خصوصی، موارد حقوقی
5. [open-questions.md](05-open-questions.md): سؤال‌های باز برای مشتری، فلو به فلو
6. [architecture.md](06-architecture.md): معماری و اصول
7. [roadmap.md](07-roadmap.md): فازهای اول (یک ویژگی در هر فاز)
8. [phase-template.md](08-phase-template.md): قالب سند فاز
9. [concept.md](09-concept.md): ایده کامل (پیشنهادهای تکمیلی، هنوز تصمیم نهایی نیست)
10. [data-model.md](10-data-model.md): مدل داده، سرویس‌های gRPC و پایپ‌لاین پارس (پیشنهاد اولیه)
11. [parsing-spec.md](11-parsing-spec.md): مشخصات پارس جمله و پیامک، اطمینان و تست (پیشنهاد اولیه)
12. [security-model.md](12-security-model.md): مدل امنیت و حریم؛ تضاد E2E با Ollama (پیشنهاد)
13. [phases/phase-00-foundation.md](phases/phase-00-foundation.md): سند فاز ۰۰ (آماده برای شروع)
14. [phases/phase-01b-wallets.md](phases/phase-01b-wallets.md): سند فاز ۰۱b (کیف پول‌ها)
15. [phases/phase-02-ledger.md](phases/phase-02-ledger.md): سند فاز ۰۲ (دفتر)
16. [phases/phase-02b-transfers.md](phases/phase-02b-transfers.md): سند فاز ۰۲b (انتقال بین کیف‌ها)
17. [phases/phase-03-categories.md](phases/phase-03-categories.md): سند فاز ۰۳ (دسته‌ها و سقف)
18. [phases/phase-04-assistant.md](phases/phase-04-assistant.md): سند فاز ۰۴ (چت دستیار)
19. [phases/phase-05-sms.md](phases/phase-05-sms.md): سند فاز ۰۵ (پیامک بانک)

## محدودیت‌های بررسی
- همه صفحه‌های عمومی خونده شد، به جز `/disclosure` (دوبار خطای ۵۰۳؛ لیست شریک‌های رفرال و مدل درآمد رفرال مشخص نیست).
- `/login` و `/dashboard` با جاوااسکریپت رندر می‌شن و محتواشون گرفته نشد. فلوی ورود از مقاله راهنما استخراج شده.
- قیمت‌های `/pricing` در استخراج خراب شده بودن (جزئیات در فایل اول).
- صفحه قیمت‌ها لینک مستقیم به ویژگی‌ها نداره. توضیح ویژگی‌ها در ۲۲ مقاله `/help` بود.
- محتوا خلاصه و بازنویسی‌شده است، نه کپی عین متن سایت.
