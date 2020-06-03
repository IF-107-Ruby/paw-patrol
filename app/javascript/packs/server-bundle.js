import ReactOnRails from "react-on-rails";

import CompanyStatistics from "../bundles/app/CompanyOwnerDashboard/components/CompanyStatistics";
import WatchersBlock from "../bundles/app/TicketShowPage/components/WatchersBlock";
import Calendar from "../bundles/app/Units/components/Calendar";
import Units from "../bundles/app/shared/components/Units";
import QrCode from "qrcode.react";

ReactOnRails.register({
  CompanyStatistics,
  WatchersBlock,
  Calendar,
  QrCode,
  Units,
});
