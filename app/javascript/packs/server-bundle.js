import ReactOnRails from "react-on-rails";

import WatchersBlock from "../bundles/app/ticketShowPage/components/WatchersBlock";
import CompanyStatistics from "../bundles/app/companyOwnerDashboard/components/CompanyStatistics";
import Calendar from "../bundles/app/Units/components/Calendar";
import Units from "../bundles/app/shared/components/Units";
import QrCode from "qrcode.react";

ReactOnRails.register({
  WatchersBlock,
  CompanyStatistics,
  Calendar,
  QrCode,
  Units,
});
