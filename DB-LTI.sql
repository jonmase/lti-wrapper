-- --------------------------------------------------------

--
-- Table structure for table `lti_consumer`
--

CREATE TABLE IF NOT EXISTS `lti_consumer` (
  `consumer_key` varchar(255) NOT NULL,
  `name` varchar(45) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `lti_version` varchar(12) DEFAULT NULL,
  `consumer_name` varchar(255) DEFAULT NULL,
  `consumer_version` varchar(255) DEFAULT NULL,
  `consumer_guid` varchar(255) DEFAULT NULL,
  `css_path` varchar(255) DEFAULT NULL,
  `protected` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enable_from` datetime DEFAULT NULL,
  `enable_until` datetime DEFAULT NULL,
  `last_access` date DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lti_context`
--

CREATE TABLE IF NOT EXISTS `lti_context` (
  `consumer_key` varchar(255) NOT NULL,
  `context_id` varchar(255) NOT NULL,
  `lti_context_id` varchar(255) DEFAULT NULL,
  `lti_resource_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `settings` text,
  `primary_consumer_key` varchar(255) DEFAULT NULL,
  `primary_context_id` varchar(255) DEFAULT NULL,
  `share_approved` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lti_nonce`
--

CREATE TABLE IF NOT EXISTS `lti_nonce` (
  `consumer_key` varchar(255) NOT NULL,
  `value` varchar(32) NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lti_share_key`
--

CREATE TABLE IF NOT EXISTS `lti_share_key` (
  `share_key_id` varchar(32) NOT NULL,
  `primary_consumer_key` varchar(255) NOT NULL,
  `primary_context_id` varchar(255) NOT NULL,
  `auto_approve` tinyint(1) NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lti_user`
--

CREATE TABLE IF NOT EXISTS `lti_user` (
  `consumer_key` varchar(255) NOT NULL,
  `context_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `lti_result_sourcedid` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lti_user_users`
--

CREATE TABLE IF NOT EXISTS `lti_user_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lti_consumer_key` varchar(255) NOT NULL,
  `lti_context_id` varchar(255) NOT NULL,
  `lti_user_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lti_consumer`
--
ALTER TABLE `lti_consumer`
  ADD PRIMARY KEY (`consumer_key`);

--
-- Indexes for table `lti_context`
--
ALTER TABLE `lti_context`
  ADD PRIMARY KEY (`consumer_key`,`context_id`),
  ADD KEY `lti_context_context_FK1` (`primary_consumer_key`,`primary_context_id`);

--
-- Indexes for table `lti_nonce`
--
ALTER TABLE `lti_nonce`
  ADD PRIMARY KEY (`consumer_key`,`value`);

--
-- Indexes for table `lti_share_key`
--
ALTER TABLE `lti_share_key`
  ADD PRIMARY KEY (`share_key_id`),
  ADD KEY `lti_share_key_context_FK1` (`primary_consumer_key`,`primary_context_id`);

--
-- Indexes for table `lti_user`
--
ALTER TABLE `lti_user`
  ADD PRIMARY KEY (`consumer_key`,`context_id`,`user_id`);

--
-- Indexes for table `lti_user_users`
--
ALTER TABLE `lti_user_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lti_user_users_users1_idx` (`user_id`),
  ADD KEY `fk_lti_user_users_lti_user1_idx` (`lti_consumer_key`,`lti_context_id`,`lti_user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lti_user_users`
--
ALTER TABLE `lti_user_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `lti_context`
--
ALTER TABLE `lti_context`
  ADD CONSTRAINT `lti_context_consumer_FK1` FOREIGN KEY (`consumer_key`) REFERENCES `lti_consumer` (`consumer_key`),
  ADD CONSTRAINT `lti_context_context_FK1` FOREIGN KEY (`primary_consumer_key`, `primary_context_id`) REFERENCES `lti_context` (`consumer_key`, `context_id`);

--
-- Constraints for table `lti_nonce`
--
ALTER TABLE `lti_nonce`
  ADD CONSTRAINT `lti_nonce_consumer_FK1` FOREIGN KEY (`consumer_key`) REFERENCES `lti_consumer` (`consumer_key`);

--
-- Constraints for table `lti_share_key`
--
ALTER TABLE `lti_share_key`
  ADD CONSTRAINT `lti_share_key_context_FK1` FOREIGN KEY (`primary_consumer_key`, `primary_context_id`) REFERENCES `lti_context` (`consumer_key`, `context_id`);

--
-- Constraints for table `lti_user`
--
ALTER TABLE `lti_user`
  ADD CONSTRAINT `lti_user_context_FK1` FOREIGN KEY (`consumer_key`, `context_id`) REFERENCES `lti_context` (`consumer_key`, `context_id`);

--
-- Constraints for table `lti_user_users`
--
ALTER TABLE `lti_user_users`
  ADD CONSTRAINT `fk_lti_user_users_lti_user1` FOREIGN KEY (`lti_consumer_key`, `lti_context_id`, `lti_user_id`) REFERENCES `lti_user` (`consumer_key`, `context_id`, `user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_lti_user_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
